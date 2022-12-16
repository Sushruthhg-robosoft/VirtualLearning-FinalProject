//
//  courseOverviewViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit

class courseDetailsViewModel {
    
    let networkManeger = NetWorkManager()
    
    func joinCourse(courseId: String, completion: @escaping(String) -> Void, fail: @escaping () -> Void){
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/notification?notificationId=\(courseId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchData(request: request){ data in
            
            print(data)
            guard let status = data as? [String] else{return}
            completion(status[0])
            
            
            
        } failure: {error in
            print(error)
        }
        
    }
    
    func courseOverView(courseId: String, completion: @escaping(CourseOverview) -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/courseOverview?courseId=\(courseId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request){ data in
            guard let courseData = data as? [String: Any] else {return}
        
            guard let courseHeader = courseData["courseHeader"] as? [String: Any] else {return}
         
            guard let courseid = courseHeader["course_id"] as? Int else {return}
            guard let courseName = courseHeader["course_name"] as? String else {return}
            guard let courseImage = courseHeader["course_image"] as? String else {return}
            guard let chapterCount = courseHeader["chapter_count"] as? Int else {return}
            guard let leessonCount = courseHeader["lesson_count"] as? Int else {return}
            guard let designName = courseHeader["category_name"] as? String else {return}
        
            let courseHeaderObject = CourseHeader(courseId: courseid, courseImage: courseImage, courseName: courseName, categoryName: designName, totalNumberOfChapters: chapterCount, totalNumberofLessons: leessonCount)
            
            guard let courseIncludes = courseData["courseIncludes"] as? [String: Any] else {return}
            
            guard let totalHourVideo = courseIncludes["totalHourVideo"] as? Int else {return}
            guard let supportFiles = courseIncludes["supportFiles"] as? Bool else {return}
            guard let moduleTest = courseIncludes["moduleTest"] as? Int else {return}
            guard let fullLifetimeAccess = courseIncludes["fullLifetimeAccess"] as? Bool else {return}
            guard let accessOn = courseIncludes["accessOn"] as? String else {return}
            guard let certificateOfCompletion = courseIncludes["certificateOfCompletion"] as? Bool else {return}
            
            let courseIncludesObject = CourseIncludes(totalVideoContent: totalHourVideo, supportedFiles: supportFiles, moduleTest: moduleTest, fullLifeTimeAccess: fullLifetimeAccess, acessOn: accessOn, CertificationofCompletion: certificateOfCompletion)
          
            guard let courseOverview = courseData["overview"] as? [String: Any] else {return}
            
            guard let courseDescription = courseOverview["courseDescription"] as? String else {return}
            guard let previewCourseContent = courseOverview["previewCourseContent"] as? String else {return}
            guard let videoLink = courseOverview["videoLink"] as? String else {return}
            guard let courseOutcome = courseOverview["courseOutcome"] as? [String] else {return}
            guard let requirements = courseOverview["requirements"] as? [String] else {return}
            
            let newOverView = OverView(courseDescription: courseDescription, previewCourseContent: previewCourseContent, videoLink: videoLink, courseOutCome: courseOutcome, requirments: requirements)
            
            guard let courseInstructor = courseData["instructor"] as? [String: Any] else {return}
            
            guard let instructorName = courseInstructor["instructorName"] as? String else {return}
            guard let occupation = courseInstructor["occupation"] as? String else {return}
            let about = courseInstructor["about"] as? String 
            let emailId = courseInstructor["emailId"] as? String
            let phoneNumber = courseInstructor["phoneNumber"] as? String
            guard let profilepic = courseInstructor["profile_pic"] as? String else {return}
          
            let instructor = Instructor(instructorName: instructorName, occupation: occupation, about: about, emailId: emailId, phoneNumber: phoneNumber, profilePic: profilepic)
            guard let joinedCourse = courseData["joined_course"] as? Bool else {return}
            
            let courseOverViewData = CourseOverview(courseHeader: courseHeaderObject, courseIncludes: courseIncludesObject, overView: newOverView, Instructor: instructor, joinedCourse: joinedCourse)
            
            completion(courseOverViewData)
            
        } failure: {error in
            print(error)
            fail()
        }
    }

    
}
