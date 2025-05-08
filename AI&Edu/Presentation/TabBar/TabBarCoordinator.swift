//
//  TabBarCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit
import Combine

final class TabBarCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let user: AnyObject?
    private(set) weak var tabBarController: TabBarController?

    private var cancellable: AnyCancellable?

    init(window: UIWindow, user: AnyObject?) {
        self.window = window
        self.user = user

        super.init()
        handleSelectTabNotifications()
    }

    override func start() {
        let viewModel = TabBarViewModelImpl()

        let coordinators = createCoordinators()
        coordinators.forEach { start(coordinator: $0) }

        let viewControllers = coordinators.map(\.navigationController)
        let tabBarController = TabBarController(viewModel: viewModel)
        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.setAsRootViewController(to: window, animated: false)
        self.tabBarController = tabBarController

        observeUnreadNotificationCount()
    }

//    func handleDeeplink(url: URL) {
//        tabBarController?.viewModel.handleDeeplink(url: url)
//    }

    // MARK: Helper methods

    private func observeUnreadNotificationCount() {

    }

    private func handleSelectTabNotifications() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleSelectHomeTabNotification),
//            name: .selectHomeTab,
//            object: nil
//        )
    }

    @objc
    private func handleSelectHomeTabNotification() {
        selectHomeTab()
    }

    private func selectHomeTab(completion: (() -> Void)? = nil) {
        selectTab(of: HomeCoordinator.self, completion: completion)
    }

    private func selectHistoryTab(completion: (() -> Void)? = nil) {
        selectTab(of: SettingsCoordinator.self, completion: completion)
    }

    private func selectTab<C>(of coordinatorType: C.Type, completion: (() -> Void)?) where C: Coordinator {
        if let tabBarController = window.rootViewController as? TabBarController,
           let index = childCoordinators.firstIndex(where: { $0 is C }) {
            tabBarController.selectedIndex = index

            let coordinator = childCoordinators[index]
            coordinator.navigationController.popToRootViewController(animated: false)
            closeAllViewControllers(from: tabBarController, completion: completion)
        }
    }

    private func createCoordinators() -> [Coordinator] {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.navigationController = BaseNavigationController()
        let homeVC = homeCoordinator.navigationController
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")?.withTintColor(.gray)
        homeVC.tabBarItem.selectedImage = UIImage(named: "house")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        homeVC.title = "Home"

        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.navigationController = BaseNavigationController()
        let settingsVC = settingsCoordinator.navigationController
        settingsVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")?.withTintColor(.gray)
        settingsVC.tabBarItem.selectedImage = UIImage(named: "gearshape")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        settingsVC.title = "Settings"

//        let marketCoordinator = MarketCoordinator()
//        marketCoordinator.navigationController = BaseNavigationController()
//        let marketVC = marketCoordinator.navigationController
//        marketVC.tabBarItem.image = UIImage(systemName: "cart")?.withTintColor(.gray)
//        marketVC.tabBarItem.selectedImage = UIImage(systemName: "cart")?.withTintColor(.black, renderingMode: .alwaysOriginal)
//        marketVC.title = "Market"

//        let profileCoordinator = ProfileCoordinator()
//        profileCoordinator.navigationController = BaseNavigationController()
//        let profileVC = profileCoordinator.navigationController
//        profileVC.tabBarItem.image = UIImage(named: "iconProfile")?.withTintColor(.gray)
//        profileVC.tabBarItem.selectedImage = UIImage(named: "iconProfile")?.withTintColor(.black, renderingMode: .alwaysOriginal)
//        profileVC.title = "Profile"

        return [
            homeCoordinator,
            settingsCoordinator
        ]
    }

    private func closeAllViewControllers(from rootViewController: UIViewController, completion: (() -> Void)? = nil) {
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.popToRootViewController(animated: false)

        } else if let tabBarController = rootViewController as? UITabBarController {
            for viewController in tabBarController.viewControllers ?? [] {
                closeAllViewControllers(from: viewController)
            }
        }

        if let presentedViewController = rootViewController.presentedViewController {
            closeAllViewControllers(from: presentedViewController) {
                presentedViewController.dismiss(animated: false, completion: completion)
            }
        } else {
            completion?()
        }
    }

    private func startCoordinator(_ coordinator: Coordinator, parent parentCoordinator: Coordinator) {
        coordinator.navigationController = parentCoordinator.navigationController
        parentCoordinator.start(coordinator: coordinator)
    }
}

