//
//  CourseModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 17/04/25.
//

import Foundation

struct CourseModel {
    let title: String
    let description: String
    let image: String
    let courseItems: [CourseItemModel]
    let level: String
}

struct CourseItemModel {
    let title: String
    let description: String
}
