//
//  HomeViewModelMock.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 02/06/25.
//

import UIKit
import Combine

class HomeViewModelMock: HomeViewModelProtocol {
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    weak var delegate: HomeCoordinatorDelegate?

    var courses: [CourseModel] = []

    func getCourses() {
        let courses: [CourseModel] = [
            CourseModel(id: 1, title: "English A1", description: "Learning English from zero", image: "", level: "B1 Intermediate"),
            CourseModel(id: 2, title: "English A2", description: "Improve your reading skill", image: "", level: "B2 Intermediate"),
            CourseModel(id: 3, title: "Math", description: "Easy ways to calculate", image: "", level: "A1 Beginner"),
            CourseModel(id: 4, title: "Mother Language", description: "Learn grammar of your native language", image: "", level: "")
        ]

        self.courses = courses
    }

    func showCourses(courseId: Int) {
        delegate?.showCourseItems(courseId: courseId)
    }
}
