//
//  myCourse.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import Foundation

class Course{
    
    var courseId: String
    var courseImage: String
    var courseName: String
    var completedCount: String
    var totalNumberOfChapters: String
    var ongoingStatus: Bool
    
    init(courseId: String,courseImage: String, courseName: String, completedCount: String, totalNumberOfChapters: String, ongoingStatus: Bool) {
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.completedCount = completedCount
        self.totalNumberOfChapters = totalNumberOfChapters
        self.ongoingStatus = ongoingStatus
    }
    
}
