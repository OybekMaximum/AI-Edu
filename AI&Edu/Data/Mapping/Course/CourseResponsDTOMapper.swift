//
//  CourseResponsDTOMapper.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/05/25.
//

import Foundation

struct CourseResponseDTOMapper: Mapper {
    func map(_ source: CourseResponseDTO) -> CourseModel {
        let videoLessonMapper = VideoLessonResponseDTOMapper()

        return CourseModel(
            title: source.title ?? "No title",
            description: source.description ?? "No description",
            image: "",
            courseItems: source.videoLessons.map { videoLessonMapper.map($0) },
            level: ""
        )
    }
}

struct VideoLessonResponseDTOMapper: Mapper {
    func map(_ source: VideoLessonResponseDTO) -> CourseItemModel {
        let courseMapper = CourseResponseDTOMapper()

        return CourseItemModel(
            title: source.title ?? "No title",
            description: "No description",
            isCompleted: false,
            courseModel: source.course == nil ? nil : courseMapper.map(source.course!),
            videoURL: source.videoUrl
        )
    }
}
