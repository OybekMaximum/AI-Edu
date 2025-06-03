//
//  KeychainHelper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 03/06/25.
//

import Foundation

final class KeychainHelper {
    public static let standart = KeychainHelper()

    init() { }

    func save(_ value: Data, service: String, account: String) {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to save in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,

            // kSecValueData is the item value to save
            kSecValueData as String: value as AnyObject
        ]

        // SecItemAdd attempts to add the item identified by
        // the query to keychain
        let status = SecItemAdd(query as CFDictionary, nil)

        // Update item if already exist
        if status == errSecDuplicateItem {
            update(value, service: service, account: account)
        } else if status != errSecSuccess {
            print("Keychain save error: \(status)")
        }
    }

    private func update(_ value: Data, service: String, account: String) {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to update in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        // attributes is passed to SecItemUpdate with
        // kSecValueData as the updated item value
        let attributes: [String: AnyObject] = [
            kSecValueData as String: value as AnyObject
        ]

        // SecItemUpdate attempts to update the item identified
        // by query, overriding the previous value
        SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )
    }

    func read(service: String, account: String) -> Data? {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to read in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,

            // kSecMatchLimitOne indicates keychain should read
            // only the most recent item matching this query
            kSecMatchLimit as String: kSecMatchLimitOne,

            // kSecReturnData is set to kCFBooleanTrue in order
            // to retrieve the data for the item
            kSecReturnData as String: kCFBooleanTrue
        ]

        // SecItemCopyMatching will attempt to copy the item
        // identified by query to the reference `result`
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        return result as? Data
    }

    func delete(service: String, account: String) {
        let query: [String: AnyObject] = [
            // kSecAttrService,  kSecAttrAccount, and kSecClass
            // uniquely identify the item to delete in Keychain
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        // SecItemDelete attempts to perform a delete operation
        // for the item identified by query.
        SecItemDelete(query as CFDictionary)
    }
}

