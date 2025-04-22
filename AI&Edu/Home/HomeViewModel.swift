//
//  HomeViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var courses: [CourseModel] { get }
}

class HomeViewModel: HomeViewModelProtocol {
    let courses: [CourseModel] = [
        .init(title: "English A1", description: "Learning English from zero", image: "", courseItems: [
            .init(title: "", description: ""),
            .init(title: "", description: "")
        ], level: "B1 Intermediate"),
        .init(title: "English A2", description: "Improve your reading skill", image: "", courseItems: [
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: "")
        ], level: "B2 Intermediate"),
        .init(title: "Math", description: "Easy ways to calculate", image: "", courseItems: [
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: ""),
            .init(title: "", description: ""),
        ], level: "A1 Beginner"),
        .init(title: "Mother Language", description: "Learn grammar of your native language", image: "", courseItems: [.init(title: "", description: "")], level: ""),
    ]
}
