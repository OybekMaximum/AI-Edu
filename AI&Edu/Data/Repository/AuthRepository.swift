//
//  AuthRepository.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 18/05/25.
//

import Foundation
import Alamofire

final class AuthRepository {
    private let session = Session.shared
    private let baseUrl = BuildConfiguration.shared.apiBaseUrl
    private lazy var url = "\(baseUrl)/api/register"

    func register(login: String, email: String, password: String) async throws {
        let parameters = [
            "login": login,
            "firstName": "",
            "lastName": "",
            "email": email,
            "imageUrl": "",
            "password": password
        ]

        _ = try await session
            .request(
                url,
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .serializingDecodable(Empty.self, emptyResponseCodes: [200, 201])
            .response
            .mapNetworkError()
            .result
            .get()
    }

    func signIn(login: String, password: String) async throws -> String {
        let parameters = [
            "username": login,
            "password": password,
        ]
        return try await session
            .request(
                "\(baseUrl)/api/authenticate",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .serializingDecodable(TokenResponseDTO.self)
            .result
            .mapError { NetworkErrorMapper().map($0) }
            .get()
            .token ?? ""
    }
}
