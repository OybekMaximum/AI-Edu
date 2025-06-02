//
//  CourseItemsViewModelMock.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 02/06/25.
//

import UIKit
import Combine

class CourseItemsViewModelMock: CourseItemsViewModelProtocol {
    var reloadTableView: PassthroughSubject<Void, Never> = .init()
    var showError: PassthroughSubject<String, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()

    let courseId: Int
    var courseItems: [CourseItemModel] = []

    private let repository: CoursesRepository
    private var retryCount = 0
    private let maxRetries = 3

    init(courseId: Int, repository: CoursesRepository = CoursesRepository()) {
        self.courseId = courseId
        self.repository = repository
        getCourseItems(courseId: courseId)
    }

    func getCourseItems(courseId: Int) {
        let courseItems: [CourseItemModel] = [
            CourseItemModel(
                title: "Introduction to the Course",
                itemType: "video",
                videoURL: "https://example.com/videos/intro.mp4"
            ),
            CourseItemModel(
                title: "Basic Grammar Rules",
                itemType: "video",
                videoURL: "https://example.com/videos/grammar.mp4"
            ),
            CourseItemModel(
                title: "Practice Exercises",
                itemType: "quiz",
                videoURL: nil
            ),
            CourseItemModel(
                title: "Reading Comprehension",
                itemType: "reading",
                videoURL: nil
            ),
            CourseItemModel(
                title: "Speaking Practice",
                itemType: "video",
                videoURL: "https://example.com/videos/speaking.mp4"
            ),
            CourseItemModel(
                title: "Final Assessment",
                itemType: "quiz",
                videoURL: nil
            )
        ]

        self.courseItems = courseItems
    }
}
