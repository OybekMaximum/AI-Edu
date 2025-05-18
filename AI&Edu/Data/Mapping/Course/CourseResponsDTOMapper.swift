//
//  CourseResponsDTOMapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/05/25.
//

import Foundation

struct CourseResponseDTOMapper: Mapper {
    func map(_ source: CourseResponseDTO) -> CourseModel {

        return CourseModel(
            id: source.id ?? 0,
            title: source.title ?? "",
            description: source.description ?? "",
            image: "",
            level: ["Beginner", "Intermediate", "Advanced", "Elementary"].randomElement() ?? ""
        )
    }
}

struct VideoLessonResponseDTOMapper: Mapper {
    func map(_ source: VideoLessonResponseDTO) -> CourseItemModel {

        return CourseItemModel(
            title: source.title ?? "No title",
            itemType: source.itemType ?? "No type",
            videoURL: source.videoUrl
        )
    }
}
