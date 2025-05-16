//
//  AIWritingTaskCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 16/05/25.
//

import UIKit

class AIWritingTaskCoordinator: BaseCoordinator {
    override func start() {
        let controller = AIWritingTaskController()
        navigationController.present(controller, animated: true)
    }

}
