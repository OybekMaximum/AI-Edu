//
//  HomeCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func showCourseItems(courseId: Int)
}

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        let controller = HomeController(viewModel: viewModel)

        navigationController.viewControllers = [controller]
    }
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    func showCourseItems(courseId: Int) {
        let coordinator = CourseItemsCoordinator(courseId: courseId)
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}


//        let coordinator = AIWritingTaskCoordinator()
//        coordinator.navigationController = navigationController
//        start(coordinator: coordinator)
//    }
//}
