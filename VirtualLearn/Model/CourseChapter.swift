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
    var courseContentResponse: CourseContentResponse
    var lessonResponseList: [LessonResponseList]
    
    init(joinedCourse: Bool,certificateResponse: Certificate?,certificateGenerated: Bool, lessonResponseList: [LessonResponseList], courseContentResponse: CourseContentResponse){
        
        self.joinedCourse = joinedCourse
        self.certificateResponse = certificateResponse
        self.certificateGenerated = certificateGenerated
        self.lessonResponseList = lessonResponseList
        self.courseContentResponse = courseContentResponse
       
    }
}
class CourseContentResponse {
    
    var courseId: Int
    var chapterCount: Int
    var lessonCount: Int
    var moduleTest: Int
    var totalVideoLength: Int
    
    init(courseId: Int, chapterCount: Int, lessonCount: Int, moduleTest: Int, totalVideoLength: Int){
        
        self.courseId = courseId
        self.chapterCount = chapterCount
        self.lessonCount = lessonCount
        self.moduleTest = moduleTest
        self.totalVideoLength = totalVideoLength
    }
}

class LessonResponseList {
    
    var chapterId: Int
    var chapterNumber: String
    var chapterName: String
    var chapterCompleted: Bool
    var isExpandable: Bool = false
    var lessonList: [Any]
    
    
    init(chapterId: Int, chapterNumber: String, chapterName: String, chapterCompleted: Bool, lessonList:[Any]){
        self.chapterId = chapterId
        self.chapterNumber = chapterNumber
        self.chapterName = chapterName
        self.chapterCompleted = chapterCompleted
        self.lessonList = lessonList

    }
    
}


class LessonList{
    
    var lessonId: Int
    var lessonNumber: String
    var lessonName: String
    var videoLink: String
    var duration: Int
    var lessonCompleted: Bool
    var nextPlay = false
    
    
    init(lessonId: Int,lessonNumber: String, lessonName: String, videoLink: String, duration: Int,  lessonCompleted: Bool){
        
        self.lessonId = lessonId
        self.lessonNumber = lessonNumber
        self.lessonName = lessonName
        self.videoLink = videoLink
        self.duration = duration
        self.lessonCompleted = lessonCompleted
        
    }
}

