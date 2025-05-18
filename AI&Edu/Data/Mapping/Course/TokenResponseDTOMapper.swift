//
//  TokenResponseDTOMapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 18/05/25.
//

import Foundation

struct TokenResponseDTOMapper: Mapper {
    func map(_ source: TokenResponseDTO) -> String {

        return source.token ?? ""
    }
}
