//
//  SettingsViewModel.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import Foundation

protocol SettingsViewModelProtocol: AnyObject {
    func logout()
}

class SettingsViewModel: SettingsViewModelProtocol {
    weak var delegate: SettingsCoordinatorDelegate?

    func logout() {
        delegate?.logout()
    }
}
