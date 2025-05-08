//
//  Alamofire+Extensions.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation
import Alamofire

extension Session {
    static var shared: Session {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        let logger = NetworkLogger()

        var headers = configuration.headers

//        if let deviceId {
//            headers.add(name: "DeviceId", value: deviceId)
//        }
//
//        if let metricToken = AppPreferenceManager.shared.userIdForAnalytics {
//            headers.add(name: "Metric-Token", value: metricToken)
//        }

        configuration.headers = headers

        return Session(configuration: configuration, eventMonitors: [logger])
    }
}

extension DataTask {
    func map<ValueMapper: Mapper, ErrorMapper: Mapper>(
        value valueMapper: ValueMapper,
        error errorMapper: ErrorMapper
    ) async throws -> ValueMapper.Destination where ValueMapper.Source == Value {
        let response = await self.response
        switch response.result {
        case .success(let value):
            return valueMapper.map(value)
        case .failure(let error):
            if let urlError = error.underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    throw NetworkError.noInternetConnection
                default:
                    break
                }
            }

            if let statusCode = error.responseCode, (500..<600).contains(statusCode) {
                throw NetworkError.serverError
            }

            guard let statusCode = error.responseCode, statusCode >= 400 && statusCode < 500 else {
                throw error
            }

            guard let data = response.data, let errorResponse = try? JSONDecoder().decode(ErrorResponseDTO.self, from: data) else {
                throw AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
            }

            let model = NetworkErrorInfo(
                path: errorResponse.path,
                status: .init(
                    code: errorResponse.status?.code,
                    message: errorResponse.status?.message),
                message: errorResponse.message
            )

            throw NetworkError.clientError(model)
        }
    }
}

extension DataResponse {
    func mapNetworkError() -> DataResponse<Success, DomainError> where Failure == AFError {

        let newResult: Result<Success, DomainError>
        switch result {
        case .success(let success):
            newResult = .success(success)
        case .failure(let failure):
            let mapper = NetworkErrorMapper(data: data)
            newResult = .failure(.network(mapper.map(failure)))
        }

        return DataResponse<Success, DomainError>(
            request: request,
            response: response,
            data: data,
            metrics: metrics,
            serializationDuration: serializationDuration,
            result: newResult
        )
    }
}

