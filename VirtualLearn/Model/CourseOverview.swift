//
//  CourseOverview.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 16/12/22.
//

import Foundation

class CourseOverview{
    

//
//    var totalVideoContent: String
//    var supportedFiles: Bool
//    var moduleTest: String
//    var fullLifeTimeAccess: Bool
//    var acessOn: String
//    var CertificationofCompletion: Bool
//
//    var courseDescription: String
//    var previewCourseContent: String
//    var videoLink: String
//    var courseOutCome: [String]
//    var requirments: String
//
//    var instructorName: String
//    var occupation: String
//    var about: String
//    var emailId: String
//    var phoneNumber: String
//    var profilePic: String
    
    
//    init(courseId: String,courseImage: String, courseName: String,categoryName:String, totalNumberOfChapters: String,totalNumberofLessons: String) {
//
//        self.courseId = courseId
//        self.courseImage = courseImage
//        self.courseName = courseName
//        self.categoryName = categoryName
//        self.totalNumberOfChapters = totalNumberOfChapters
//        self.totalNumberofLessons = totalNumberofLessons
//
//    }
    
}

class CourseHeader {
    var courseId: String
    var courseImage: String
    var courseName: String
    var categoryName: String
    var totalNumberOfChapters: String
    var totalNumberofLessons: String
    
    init(courseId: String,courseImage: String, courseName: String,categoryName:String, totalNumberOfChapters: String,totalNumberofLessons: String) {
        
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.categoryName = categoryName
        self.totalNumberOfChapters = totalNumberOfChapters
        self.totalNumberofLessons = totalNumberofLessons
        
    }
}
