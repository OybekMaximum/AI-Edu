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
        "http://localhost:7777"
    }
}
