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
    
    
    var courseContentResponse : CourseContentResponse?
    var lessonResponseList: LessonResponseList?
    var lessonList: LessonList?
    
   
   
    init(joinedCourse: Bool,certificateResponse: Certificate?,certificateGenerated: Bool){
        
        self.joinedCourse = joinedCourse
        self.certificateResponse = certificateResponse
        self.certificateGenerated = certificateGenerated
       
        
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
    var chapterName: String
    var chapterCompleted: Bool
    var assignmentResponse: AssignmentResponse?
    
    
    init(chapterId: Int, chapterName: String, chapterCompleted: Bool,assignmentResponse: AssignmentResponse?){
        self.chapterId = chapterId
        self.chapterName = chapterName
        self.chapterCompleted = chapterCompleted
        self.assignmentResponse = assignmentResponse

    }
    
}


class LessonList{
    
    var lessonId: Int
    var lessonName: String
    var videoLink: String
    var duration: Int
    var lessonCompleted: Bool
    
    
    init(lessonId: Int, lessonName: String, videoLink: String, duration: Int,  lessonCompleted: Bool){
        
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.videoLink = videoLink
        self.duration = duration
        self.lessonCompleted = lessonCompleted
        
    }
}

