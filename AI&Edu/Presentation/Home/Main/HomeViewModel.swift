//
//  HomeViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    var courses: [CourseModel] { get }
    var delegate: HomeCoordinatorDelegate? { get set }
    var reloadTableView: PassthroughSubject<Void, Never> { get }

    func getCourses()
    func showCourses(courseId: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    weak var delegate: HomeCoordinatorDelegate?

    var courses: [CourseModel] = []

    func getCourses() {
        let repository = CoursesRepository()

        Task { @MainActor in
            do {
                let courses = try await repository.getCourses()
                self.courses = courses
                reloadTableView.send()
            } catch {
                print("CoursesRepository Error occured")
            }
        }
    }

    func showCourses(courseId: Int) {
        delegate?.showCourseItems(courseId: courseId)
    }
}
