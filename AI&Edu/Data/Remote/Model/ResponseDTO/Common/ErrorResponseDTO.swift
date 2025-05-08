//
//  ErrorResponseDTO.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation

struct ErrorResponseDTO: Decodable {
    struct Status: Decodable {
        let code: String?
        let message: String?
    }

    struct Validation: Decodable {
        let key: String?
        let message: String?
    }

    let path: String?
    let status: Status?
    let message: String?
    let validations: [Validation]?
}
