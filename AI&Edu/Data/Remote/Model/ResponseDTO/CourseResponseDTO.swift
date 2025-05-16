//
//  CourseResponseDTO.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/05/25.
//

import Foundation

struct CourseResponseDTO: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let videoLessons: [VideoLessonResponseDTO]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case videoLessons
    }
}

struct VideoLessonResponseDTO: Decodable {
    let id: Int?
    let title: String?
    let course: CourseResponseDTO?
    let videoUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case course
        case videoUrl
    }
}
