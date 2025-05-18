//
//  CourseItemsCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import Foundation

class CourseItemsCoordinator: BaseCoordinator {
    let courseId: Int

    init(courseId: Int) {
        self.courseId = courseId
        super.init()
    }

    override func start() {
        let viewModel = CourseItemsViewModel(courseId: courseId)
        let controller = CourseItemsController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
