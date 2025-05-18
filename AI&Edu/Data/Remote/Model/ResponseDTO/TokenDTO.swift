//
//  TokenDTO.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 18/05/25.
//

import Foundation

struct TokenResponseDTO: Decodable {
    let token: String?

    enum CodingKeys: String, CodingKey {
        case token = "id_token"
    }
}
