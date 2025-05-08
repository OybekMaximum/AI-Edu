//
//  AuthCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import UIKit

protocol AuthCoordinatorDelegate: AnyObject {
    func showMain()
}

class AuthCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        super.init()
    }

    override func start() {
        let viewModel = AuthViewModel()
        viewModel.coordinatorDelegate = self
        let controller = AuthViewController(viewModel: viewModel)

        controller.setAsRootViewController(to: window, animated: false)
    }

}

extension AuthCoordinator: AuthCoordinatorDelegate {
    private var appCoordinator: AppCoordinator? {
        var parentCoordinator = parentCoordinator
        while let coordinator = parentCoordinator?.parentCoordinator {
            parentCoordinator = coordinator
        }

        return parentCoordinator as? AppCoordinator
    }

    func showMain() {
        appCoordinator?.showMainPage()
    }
}
