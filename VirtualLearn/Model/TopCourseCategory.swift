//
//  TopCourseCategory.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 19/12/22.
//

import Foundation

class TopCourseCategory{
    var courseId: String
    var courseImage: String
    var courseName: String
    
    var completedCount: String
    var totalNumberOfChapters: String
    var categoryName: String
    var videoLength: String
    var lessonCount: String
    
    init(courseId: String,courseImage: String, courseName: String, completedCount: String, totalNumberOfChapters: String, categoryName: String,videoLength: String, lessonCount: String) {
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.completedCount = completedCount
        self.totalNumberOfChapters = totalNumberOfChapters
        self.categoryName = categoryName
        self.videoLength = videoLength
        self.lessonCount = lessonCount

        
    }
}
