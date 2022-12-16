//
//  CourseChapter.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation


class CourseChapter {
    
    
    var joinedCourse: Bool
    var certificateResponse: Certificate?
    var certificateGenerated: Bool
    var courseId: Int
    var chapterCount: Int
    var lessonCount: Int
    var moduleTest: Int
    var totalVideoLength: Int
    var chapterId: Int
    var chapterName: String
    var chapterCompleted: Bool
    var lessonId: Int
    var lessonName: String
    var videoLink: String
    var duration: Int
    var lessonCompleted: Bool
    var assignmentResponse: Bool
    
    init(joinedCourse: Bool,certificateResponse: Certificate,certificateGenerated: Bool, courseId: Int, chapterCount: Int, lessonCount: Int, moduleTest: Int, totalVideoLength: Int, chapterId: Int, chapterName: String, chapterCompleted: Bool, lessonId: Int, lessonName: String, videoLink: String, duration: Int,  lessonCompleted: Bool, assignmentResponse: Bool){
        
        self.joinedCourse = joinedCourse
        self.certificateResponse = certificateResponse
        self.certificateGenerated = certificateGenerated
        self.courseId = courseId
        self.chapterCount = chapterCount
        self.lessonCount = lessonCount
        self.moduleTest = moduleTest
        self.totalVideoLength = totalVideoLength
        self.chapterId = chapterId
        self.chapterName = chapterName
        self.chapterCompleted = chapterCompleted
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.videoLink = videoLink
        self.duration = duration
        self.lessonCompleted = lessonCompleted
        self.assignmentResponse = assignmentResponse
        
    }
    
}
