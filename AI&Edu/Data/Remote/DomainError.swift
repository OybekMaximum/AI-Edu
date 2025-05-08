//
//  DomainError.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation

enum DomainError: LocalizedError {
    case network(NetworkError)
    case unknown

    var errorDescription: String? {
        switch self {
        case .network(let networkError):
            switch networkError {
            case .clientError(let model): return model.message
            default: return nil
            }
        case .unknown:
            return localizedDescription
        }
    }
}
