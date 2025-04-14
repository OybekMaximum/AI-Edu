//
//  AuthViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import Foundation

protocol AuthViewModelProtocol: AnyObject {
    func showMain()
}

class AuthViewModel: AuthViewModelProtocol {
    weak var coordinatorDelegate: AuthCoordinatorDelegate?

    func showMain() {
        coordinatorDelegate?.showMain()
    }
}
