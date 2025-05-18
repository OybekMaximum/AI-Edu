//
//  CoursesRepository.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/05/25.
//

import Foundation
import Alamofire

final class CoursesRepository {
    private let session = Session.shared
    private let baseUrl = BuildConfiguration.shared.apiBaseUrl
    private lazy var url = "\(baseUrl)/api/courses"

    func getCourses() async throws -> [CourseModel] {
        return try await session
            .request(
                url,
                method: .get
            )
            .validate()
            .serializingDecodable([CourseResponseDTO].self)
            .response
            .map { $0.map { CourseResponseDTOMapper().map($0) } }
            .mapNetworkError()
            .result
            .get()
    }
}

//    func confirmSignIn(phone: String, confirmationId: String, confirmationCode: String) async throws -> OAuthCredential {
//        let appVersion = Bundle.main.appVersion
//        let parameters = [
//            "phone": phone,
//            "otp_id": confirmationId,
//            "code": confirmationCode,
//            "app_version": appVersion
//        ]
//        return try await session
//            .request(
//                "\(url)/sign-in/verify",
//                method: .post,
//                parameters: parameters,
//                encoder: JSONParameterEncoder.default
//            )
//            .validate()
//            .serializingDecodable(OAuthCredentialResponseDTO.self)
//            .response
//            .map { OAuthCredentialResponseDTOMapper().map($0) }
//            .mapNetworkError()
//            .result
//            .get()
//    }
//}
