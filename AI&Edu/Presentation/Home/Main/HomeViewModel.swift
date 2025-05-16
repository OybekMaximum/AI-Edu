//
//  HomeViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var courses: [CourseModel] { get }
    var delegate: HomeCoordinatorDelegate? { get set }

    func showCourses(items: [CourseItemModel])
}

class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeCoordinatorDelegate?

//    let courses: [CourseModel] = [
//        .init(title: "English A1", description: "Learning English from zero", image: "", courseItems: [
//            .init(title: "Future simple", description: "Simple Future Tense", isCompleted: true),
//            .init(title: "Modal Verbs ", description: "Can, Should, Must, Have to", isCompleted: false)
//        ], level: "B1 Intermediate"),
//        .init(title: "English A2", description: "Improve your reading skill", image: "", courseItems: [
//            .init(title: "Conditionals", description: "Conditional sentences", isCompleted: true),
//            .init(title: "Passive Voice", description: "Present and Past", isCompleted: false),
//            .init(title: "Gerunds and Infinitives", description: "Verbs ending in -ing or with 'to'", isCompleted: false),
//            .init(title: "Passive Voice", description: "Present and Past", isCompleted: false),
//            .init(title: "Gerunds and Infinitives", description: "Verbs ending in -ing or with 'to'", isCompleted: false),
//            .init(title: "Passive Voice", description: "Present and Past", isCompleted: false)
//        ], level: "B2 Intermediate"),
//        .init(title: "Math", description: "Easy ways to calculate", image: "", courseItems: [
//            .init(title: "Passive Voice", description: "Present and Past", isCompleted: true),
//            .init(title: "Gerunds and Infinitives", description: "Verbs ending in -ing or with 'to'", isCompleted: false),
//            .init(title: "Passive Voice", description: "Present and Past", isCompleted: false),
//            .init(title: "Gerunds and Infinitives", description: "Verbs ending in -ing or with 'to'", isCompleted: false)
//        ], level: "A1 Beginner"),
//        .init(title: "Mother Language", description: "Learn grammar of your native language", image: "", courseItems: [
//            .init(title: "", description: "", isCompleted: true)
//        ], level: ""),
//    ]

    let courses: [CourseModel] = [
        .init(
            title: "title",
            description: "description",
            image: "",
            courseItems: [.init(
                title: "lesson title",
                description: "lesson description",
                isCompleted: false,
                courseModel: nil,
                videoURL: ""
            )],
            level: "Zero"
        )
    ]

    func showCourses(items: [CourseItemModel]) {
        delegate?.showCourseItems(items: items)
    }
}
