//
//  Coordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func finish()
}

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }

    func start()
    func start(coordinator: Coordinator)
    func removeChildCoordinators()
    func removeFromParent()
}

class BaseCoordinator: NSObject, Coordinator, CoordinatorDelegate {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    deinit {
        print("Deinit \(type(of: self))")
    }

    func start() {
        fatalError("Start method should be implemented")
    }

    func start(coordinator: Coordinator) {
        childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func finish() {
        removeChildCoordinators()
        removeFromParent()
    }

    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }

    func removeFromParent() {
        if let index = parentCoordinator?.childCoordinators.firstIndex(where: { $0 === self }) {
            parentCoordinator?.childCoordinators.remove(at: index)
        }
    }
}
