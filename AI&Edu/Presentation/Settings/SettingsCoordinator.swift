//
//  SettingsCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol SettingsCoordinatorDelegate: CoordinatorDelegate {
    func logout()
}

class SettingsCoordinator: BaseCoordinator {
    override func start() {
        let viewModel = SettingsViewModel()
        viewModel.delegate = self
        let controller = SettingsController(viewModel: viewModel)

        navigationController.viewControllers = [controller]
    }
}

extension SettingsCoordinator: SettingsCoordinatorDelegate {
    func logout() {
        UserManager.shared.logout()
        appCoordinator?.showAuthPage()
    }

    private var appCoordinator: AppCoordinator? {
        var parentCoordinator = parentCoordinator
        while let coordinator = parentCoordinator?.parentCoordinator {
            parentCoordinator = coordinator
        }

        return parentCoordinator as? AppCoordinator
    }
}
