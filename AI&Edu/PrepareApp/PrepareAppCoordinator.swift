//
//  PrepareAppCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit

protocol PrepareAppCoordinatorDelegate: CoordinatorDelegate {
    func launchApp()
}

final class PrepareAppCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        let viewModel = PrepareAppViewModel()
        viewModel.coordinatorDelegate = self

        let controller = PrepareAppController(viewModel: viewModel)

        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

extension PrepareAppCoordinator: PrepareAppCoordinatorDelegate {
    private var appCoordinator: AppCoordinator? {
        var parentCoordinator = parentCoordinator
        while let coordinator = parentCoordinator?.parentCoordinator {
            parentCoordinator = coordinator
        }

        return parentCoordinator as? AppCoordinator
    }

    func launchApp() {
        appCoordinator?.launchApp()
    }
}
