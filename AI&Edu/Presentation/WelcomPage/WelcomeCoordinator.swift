//
//  FirstWelcomeCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 16/05/25.
//

import UIKit

protocol FirstWelcomeCoordinatorDelegate: CoordinatorDelegate {
    func showNext()
    func showWritingTest()
    func showHome()
}

class FirstWelcomeCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        super.init()
    }

    override func start() {
        let controller = FirstWelcomeController()
        controller.coordinatorDelegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

    }
}

extension FirstWelcomeCoordinator: FirstWelcomeCoordinatorDelegate {
    func showNext() {
        let controller = SecondWelcomeController()
        controller.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: false)
    }

    func showWritingTest() {
        let controller = AIWritingTaskController()
        controller.coordinatorDelegate = self
        navigationController.present(controller, animated: true)
    }

    func showHome() {
        appCoordinator?.showMainPage()
    }
}

extension FirstWelcomeCoordinator {
    private var appCoordinator: AppCoordinator? {
        var parentCoordinator = parentCoordinator
        while let coordinator = parentCoordinator?.parentCoordinator {
            parentCoordinator = coordinator
        }

        return parentCoordinator as? AppCoordinator
    }
}
