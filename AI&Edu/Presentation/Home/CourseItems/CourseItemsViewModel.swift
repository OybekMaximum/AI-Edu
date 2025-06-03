//
//  CourseItemsViewModel.swift
//  AI&Edu
//
//  Created by Oybek To'laboyev on 22/04/25.
//

import Foundation
import Combine

protocol CourseItemsViewModelProtocol: AnyObject {
    var courseId: Int { get }
    var courseItems: [CourseItemModel] { get set }
    var reloadTableView: PassthroughSubject<Void, Never> { get }
    var showError: PassthroughSubject<String, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }

    func showWritingExam()
}

class CourseItemsViewModel: CourseItemsViewModelProtocol {
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    var showError: PassthroughSubject<String, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    
    let courseId: Int
    var courseItems: [CourseItemModel] = []
    weak var coordinatorDelegate: CourseItemsCoordinatorDelegate?

    private let repository: CoursesRepository
    private var retryCount = 0
    private let maxRetries = 3

    init(courseId: Int, repository: CoursesRepository = CoursesRepository()) {
        self.courseId = courseId
        self.repository = repository
        getCoursesItems()
    }

    func getCoursesItems() {
        isLoading.send(true)
        
        Task { @MainActor in
            do {
                let items = try await repository.getCourseById(courseId: courseId)
                self.courseItems = items
                reloadTableView.send()
                retryCount = 0
            } catch let error as NetworkError {
                handleNetworkError(error)
            } catch {
                showError.send("An unexpected error occurred")
            }
            isLoading.send(false)
        }
    }

    func showWritingExam() {
        coordinatorDelegate?.showWritingExam()
    }

    private func handleNetworkError(_ error: NetworkError) {
        switch error {
        case .noInternetConnection:
            showError.send("No internet connection. Please check your connection and try again.")
        case .serverError:
            if retryCount < maxRetries {
                retryCount += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.getCoursesItems()
                }
            } else {
                showError.send("Server error. Please try again later.")
            }
        case .clientError(let info):
            showError.send(info.message ?? "An error occurred")
        default:
            showError.send("An error occurred while fetching course items")
        }
    }
}
