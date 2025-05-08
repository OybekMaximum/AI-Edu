//
//  SettingsCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

class SettingsCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = SettingsViewModel()
        let controller = SettingsController(viewModel: viewModel)

        navigationController.viewControllers = [controller]
    }
}


