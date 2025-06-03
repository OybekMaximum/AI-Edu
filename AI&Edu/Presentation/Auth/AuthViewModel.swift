//
//  AuthViewModel.swift
//  AI&Edu
//
//  Created by Oybek To'laboyev on 14/04/25.
//

import Foundation
import Combine

protocol AuthViewModelProtocol: AnyObject {
    var showSignIn: PassthroughSubject<Void, Never> { get }
    var showError: PassthroughSubject<String, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }

    func showOnboarding()
    func signIn(login: String, password: String)
    func signUp(login: String, email: String, password: String)
}

class AuthViewModel: AuthViewModelProtocol {
    weak var coordinatorDelegate: AuthCoordinatorDelegate?
    private let repository: AuthRepository
    
    var showSignIn: PassthroughSubject<Void, Never> = .init()
    var showError: PassthroughSubject<String, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    
    init(repository: AuthRepository = AuthRepository()) {
        self.repository = repository
    }

    func showOnboarding() {
        coordinatorDelegate?.showOnboarding()
    }

    func signUp(login: String, email: String, password: String) {
        guard validateSignUpInput(login: login, email: email, password: password) else {
            return
        }
        
        isLoading.send(true)
        
        Task { @MainActor in
            do {
                try await repository.register(login: login, email: email, password: password)
                showSignIn.send()
            } catch let error as NetworkError {
                handleNetworkError(error)
            } catch {
                showError.send("An unexpected error occurred")
            }
            isLoading.send(false)
        }
    }

    func signIn(login: String, password: String) {
        guard validateSignInInput(login: login, password: password) else {
            return
        }
        
        isLoading.send(true)
        
        Task { @MainActor in
            do {
                let token = try await repository.signIn(login: login, password: password)
                UserManager.shared.saveUserToken(token: token, name: login)
                showOnboarding()
            } catch let error as NetworkError {
                handleNetworkError(error)
            } catch {
                showError.send("An unexpected error occurred")
            }
            isLoading.send(false)
        }
    }
    
    private func validateSignUpInput(login: String, email: String, password: String) -> Bool {
        if login.isEmpty {
            showError.send("Login cannot be empty")
            return false
        }
        
        if email.isEmpty {
            showError.send("Email cannot be empty")
            return false
        }
        
        if !isValidEmail(email) {
            showError.send("Please enter a valid email address")
            return false
        }
        
        if password.isEmpty {
            showError.send("Password cannot be empty")
            return false
        }
        
        if password.count < 6 {
            showError.send("Password must be at least 6 characters long")
            return false
        }
        
        return true
    }
    
    private func validateSignInInput(login: String, password: String) -> Bool {
        if login.isEmpty {
            showError.send("Login cannot be empty")
            return false
        }
        
        if password.isEmpty {
            showError.send("Password cannot be empty")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func handleNetworkError(_ error: NetworkError) {
        switch error {
        case .noInternetConnection:
            showError.send("No internet connection. Please check your connection and try again.")
        case .serverError:
            showError.send("Server error. Please try again later.")
        case .clientError(let info):
            showError.send(info.message ?? "Invalid credentials")
        default:
            showError.send("An error occurred during authentication")
        }
    }
}
