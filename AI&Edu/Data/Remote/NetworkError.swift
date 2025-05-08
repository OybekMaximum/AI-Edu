//
//  NetworkError.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation

enum NetworkError: Error {
    enum ResponseValidationFailureReason {
        /// The response has not a status code.
        case noStatusCode
        /// The response status code was not acceptable.
        case unacceptableStatusCode(code: Int)
    }

    case clientError(NetworkErrorInfo)
    case responseSerializationFailed
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case serverError
    case noInternetConnection
}
