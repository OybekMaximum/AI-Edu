//
//  UserManager.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 03/06/25.
//

import Foundation

final class UserManager {
    static var shared = UserManager()

    private let keychainServiceName = "UserManager"
    private let keychainHelper = KeychainHelper()
    private let account = "123456789"

    @UserDefaultsWrapper(key: "user_name")
    private var userName: String?

    private init() { }

    var token: String? {
        guard
            let tokenData = keychainHelper.read(service: keychainServiceName, account: account),
            let decodedToken = String(data: tokenData, encoding: .utf8) else
        { return nil }

        return decodedToken
    }

    var user: String? {
        return userName
    }

    func saveUserToken(token: String, name: String) {
        keychainHelper.save(
            token.data(using: .utf8)!,
            service: keychainServiceName,
            account: account
        )

        userName = name
    }

    func logout() {
        keychainHelper.delete(service: keychainServiceName, account: account)
        UserDefaults.standard.removeObject(forKey: "user_name")
    }
}
