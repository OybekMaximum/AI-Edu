//
//  AppCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit


final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.window = window
        super.init()
    }

    override func start() {
        prepareApp()
    }

    private func showWelcomePage() {
        removeChildCoordinators()
//
//        let coordinator = WelcomeCoordinator(window: window)
//        start(coordinator: coordinator)
    }

    func prepareApp() {
        removeChildCoordinators()

        let coordinator = PrepareAppCoordinator(window: window)
        start(coordinator: coordinator)
    }

    func launchApp() {
//        showAuthPage()
        showMainPage()
    }

    func showAuthPage() {
        removeChildCoordinators()

        let coordinator = AuthCoordinator(window: window)
        start(coordinator: coordinator)
    }

    func showMainPage() {
        removeChildCoordinators()

        let coordinator = TabBarCoordinator(
            window: window,
            user: nil
        )

        start(coordinator: coordinator)
    }

    func showProfileInfo() {
//        removeChildCoordinators()
//
//        let coordinator = AddPersonalInfoCoordinator(window: window, user: user)
//        start(coordinator: coordinator)
    }
}

