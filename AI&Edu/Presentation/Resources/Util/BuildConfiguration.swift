//
//  BuildConfiguration.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/05/25.
//

import Foundation

class BuildConfiguration {
    static let shared = BuildConfiguration()

    var apiBaseUrl: String {
        "http://51.20.3.10:7777"
    }

    var token: String?
    var userName: String?
}
