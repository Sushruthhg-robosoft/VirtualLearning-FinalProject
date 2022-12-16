//
//  CourseOverview.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 16/12/22.
//

import Foundation

class CourseOverview{
    var courseHeader: CourseHeader
    var courseIncludes: CourseIncludes
    var overView: OverView
    var Instructor: Instructor
    var joinedCourse: Bool
    
    init(courseHeader: CourseHeader, courseIncludes: CourseIncludes,overView: OverView, Instructor: Instructor, joinedCourse: Bool) {
        self.courseHeader = courseHeader
        self.courseIncludes = courseIncludes
        self.overView = overView
        self.Instructor = Instructor
        self.joinedCourse = joinedCourse
    }
}

class CourseHeader {
    var courseId: Int
    var courseImage: String
    var courseName: String
    var categoryName: String
    var totalNumberOfChapters: Int
    var totalNumberofLessons: Int
    
    init(courseId: Int,courseImage: String, courseName: String,categoryName:String, totalNumberOfChapters: Int,totalNumberofLessons: Int) {
        
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.categoryName = categoryName
        self.totalNumberOfChapters = totalNumberOfChapters
        self.totalNumberofLessons = totalNumberofLessons
        
    }
}

class CourseIncludes {
    var totalVideoContent: Int
    var supportedFiles: Bool
    var moduleTest: Int
    var fullLifeTimeAccess: Bool
    var acessOn: String
    var CertificationofCompletion: Bool
    
    init(totalVideoContent: Int, supportedFiles: Bool, moduleTest: Int, fullLifeTimeAccess:Bool, acessOn: String, CertificationofCompletion: Bool) {
        
        self.totalVideoContent = totalVideoContent
        self.supportedFiles = supportedFiles
        self.moduleTest = moduleTest
        self.fullLifeTimeAccess = fullLifeTimeAccess
        self.acessOn = acessOn
        self.CertificationofCompletion = CertificationofCompletion
        
    }
}

class OverView {
    
    var courseDescription: String
    var previewCourseContent: String
    var videoLink: String
    var courseOutCome: [String]
    var requirments: [String]
    
    init(courseDescription: String, previewCourseContent: String, videoLink: String, courseOutCome:[String], requirments: [String]) {
        
        self.courseDescription = courseDescription
        self.previewCourseContent = previewCourseContent
        self.videoLink = videoLink
        self.courseOutCome = courseOutCome
        self.requirments = requirments
    }
}

class Instructor {
    var instructorName: String
    var occupation: String
    var about: String
    var emailId: String
    var phoneNumber: String
    var profilePic: String
    
    init(instructorName: String, occupation: String, about: String, emailId:String, phoneNumber: String, profilePic: String) {
        
        self.instructorName = instructorName
        self.occupation = occupation
        self.about = about
        self.emailId = emailId
        self.phoneNumber = phoneNumber
        self.profilePic = profilePic
    }
}
