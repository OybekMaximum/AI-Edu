//
//  NetworkErrorMapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation
import Alamofire

struct NetworkErrorMapper: Mapper {
    let data: Data?

    init(data: Data? = nil) {
        self.data = data
    }

    func map(_ source: AFError) -> NetworkError {
        if let urlError = source.underlyingError as? URLError,
            [.notConnectedToInternet, .networkConnectionLost].contains(urlError.code) {
            return .noInternetConnection
        }

        guard let statusCode = source.responseCode else {
            return .responseValidationFailed(reason: .noStatusCode)
        }

        if (500..<600).contains(statusCode) {
            return .serverError
        }

        if !(400..<500).contains(statusCode) {
            return .responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))
        }

        guard let data, let errorResponse = try? JSONDecoder().decode(ErrorResponseDTO.self, from: data) else {
            return .responseSerializationFailed
        }

        let model = NetworkErrorInfo(
            path: errorResponse.path,
            status: .init(
                code: errorResponse.status?.code,
                message: errorResponse.status?.message),
            message: errorResponse.message
        )

        return .clientError(model)
    }
}
