//
//  CourseItemsViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import Foundation

protocol CourseItemsViewModelProtocol: AnyObject {
    var courseItems: [CourseItemModel] { get }
}

class CourseItemsViewModel: CourseItemsViewModelProtocol {
    let courseItems: [CourseItemModel]

    init(courseItems: [CourseItemModel]) {
        self.courseItems = courseItems
    }
}
