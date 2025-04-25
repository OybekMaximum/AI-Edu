//
//  CourseItemsCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import Foundation

class CourseItemsCoordinator: BaseCoordinator {
    let courseItems: [CourseItemModel]

    init(courseItems: [CourseItemModel]) {
        self.courseItems = courseItems
        super.init()
    }

    override func start() {
        let viewModel = CourseItemsViewModel(courseItems: courseItems)
        let controller = CourseItemsController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
