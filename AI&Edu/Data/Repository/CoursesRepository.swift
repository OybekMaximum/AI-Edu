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

    func getCourses() async throws -> [CourseModel] {
        return try await session
            .request(
                baseUrl + "/api/courses",
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

    func getCourseById(courseId: Int) async throws -> [CourseItemModel] {
        let parameters = [
            "courseId": courseId,
        ]

        return try await session
            .request(
                baseUrl + "/api/courses/\(courseId)/items",
                method: .get,
                parameters: parameters
            )
            .validate()
            .serializingDecodable([VideoLessonResponseDTO].self)
            .response
            .map { $0.map { VideoLessonResponseDTOMapper().map($0) } }
            .mapNetworkError()
            .result
            .get()
    }
}
