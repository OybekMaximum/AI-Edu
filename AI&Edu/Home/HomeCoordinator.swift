//
//  HomeCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = HomeViewModel()
        let controller = HomeController(viewModel: viewModel)

        navigationController.viewControllers = [controller]
    }
}

