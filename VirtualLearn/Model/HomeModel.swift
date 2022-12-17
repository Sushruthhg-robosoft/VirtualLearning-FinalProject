//
//  HomeModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 17/12/22.
//

import Foundation

class HomeCourse{
    var courseId: String
    var courseImage: String
    var courseName: String
    var completedCount: String
    var totalNumberOfChapters: String
    var categoryName: String
    var videoLength: String
    
    init(courseId: String,courseImage: String, courseName: String, completedCount: String, totalNumberOfChapters: String, categoryName: String,videoLength: String) {
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.completedCount = completedCount
        self.totalNumberOfChapters = totalNumberOfChapters
        self.categoryName = categoryName
        self.videoLength = videoLength
        
    }
}
