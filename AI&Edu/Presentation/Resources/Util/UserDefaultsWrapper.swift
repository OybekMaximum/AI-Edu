//
//  UserDefaultsWrapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 03/06/25.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefaultsWrapper<Value> {
    let key: String
    let defaultValue: Value?
    let container: UserDefaults = .standard
    let publisher = CurrentValueSubject<Value?, Never>(nil)

    public init(key: String, defaultValue: Value? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        publisher.send(wrappedValue)
    }

    var wrappedValue: Value? {
        get { container.object(forKey: key) as? Value ?? defaultValue }
        set {
            container.setValue(newValue, forKey: key)
            publisher.send(newValue ?? defaultValue)
        }
    }
}
