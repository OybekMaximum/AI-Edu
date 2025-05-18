//
//  CourseItemsViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import Foundation
import Combine

protocol CourseItemsViewModelProtocol: AnyObject {
    var courseId: Int { get }
    var courseItems: [CourseItemModel] { get set }
    var reloadTableView: PassthroughSubject<Void, Never> { get }
}

class CourseItemsViewModel: CourseItemsViewModelProtocol {
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    let courseId: Int

    var courseItems: [CourseItemModel] = []

    init(courseId: Int) {
        self.courseId = courseId
        getCoursesItems()
    }

    func getCoursesItems()  {
        let repository = CoursesRepository()

        Task { @MainActor in
            do {
                let items = try await repository.getCourseById(courseId: courseId)
                self.courseItems = items
                reloadTableView.send()
            } catch {
                print("CoursesRepository Error occurred")
            }
        }
    }
}
