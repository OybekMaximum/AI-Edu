//
//  HomeCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func showCourseItems(items: [CourseItemModel])
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
    func showCourseItems(items: [CourseItemModel]) {
//        let coordinator = CourseItemsCoordinator(courseItems: items)
//        coordinator.navigationController = navigationController
//        start(coordinator: coordinator)

        let coordinator = AIWritingTaskCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
