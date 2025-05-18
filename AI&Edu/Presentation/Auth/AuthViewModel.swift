//
//  AuthViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import Foundation
import Combine

protocol AuthViewModelProtocol: AnyObject {
    var showSignIn: PassthroughSubject<Void, Never> { get }

    func showOnboarding()
    func signIn(login: String, password: String)
    func signUp(login: String, email: String, password: String)
}

class AuthViewModel: AuthViewModelProtocol {
    weak var coordinatorDelegate: AuthCoordinatorDelegate?
    private let repository = AuthRepository()

    var showSignIn: PassthroughSubject<Void, Never> = .init()

    func showOnboarding() {
        coordinatorDelegate?.showOnboarding()
    }

    func signUp(login: String, email: String, password: String) {
        Task { @MainActor in
            do {
                let success = try await repository.register(login: login, email: email, password: password)

                    showSignIn.send()

            } catch {
                print("Error occured")
            }
        }
    }


    func signIn(login: String, password: String) {
        Task { @MainActor in
            do {
                let token = try await repository.signIn(login: login, password: password)
                BuildConfiguration.shared.token = token
                BuildConfiguration.shared.userName = login

                showOnboarding()

            } catch {
                print("Error occured")
            }
        }
    }
}
