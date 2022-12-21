//
//  chaptersViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit

class ChaptersViewModel {
    
    let networkManeger = NetWorkManager()
    var listOfLessons = [LessonResponseList]()
    func getChapters(token: String, courseId: String,completion: @escaping(CourseChapter) -> Void, fail: @escaping () -> Void) {
        
//        var listOfLessons = [LessonResponseList]()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/chapter?courseId=3")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request) { data in
            
            guard let apiData = data as? [String:Any] else {print("apiDataerr");return}

            guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return}
            guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratederr");return}

            
            guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return}
            guard let courseId = courseContentResponse["courseId"] else{print("courseIdErr"); return}
            guard let chapterCount = courseContentResponse["chapterCount"] else{print("chapterCountErr"); return}
            guard let lessonCount = courseContentResponse["lessonCount"] else{print("lesscountErr"); return}
            guard let moduleTest = courseContentResponse["moduleTest"] else{print("moduleTestErr"); return}
            guard let totalVideoLength = courseContentResponse["totalVideoLength"] else{print("totalVideoLengthErr"); return}
            
            let CourseContentData = CourseContentResponse(courseId: courseId, chapterCount: chapterCount, lessonCount: lessonCount, moduleTest: moduleTest, totalVideoLength: totalVideoLength)
            
            guard let lessonResponseLists = apiData["lessonResponseList"] as? [[String:Any]] else{print("lessonResponseListErr"); return}
            var lessonsList = [Any]()
            for lessonResponse in lessonResponseLists {
                lessonsList.removeAll()
                guard let chapterName = lessonResponse["chapterName"] as? String else{print("chapterNameErr"); return}
                guard let chapterId = lessonResponse["chapterId"] as? Int else{print("chapterIdErr"); return}
                guard let chapterCompletionStatus = lessonResponse["chapterCompleted"] as? Bool else{print("chapterStatusErr"); return}

                guard let chapterList = lessonResponse["lessonList"] as? [[String:Any]] else{print("chapterlist Errrpr"); return}

                for lesson in chapterList {
                    guard let lessonId = lesson["lessonId"] as? Int else {return}
                    guard let lessonName = lesson["lessonName"] as? String else {return}
                    guard let videoLink = lesson["videoLink"] as? String else {return}
                    guard let duration = lesson["duration"] as? Int else {return}
                    guard let lessonCompleted = lesson["lessonCompleted"] as? Bool else {return}

                    let newLesson = LessonList(lessonId: lessonId, lessonName: lessonName, videoLink: videoLink, duration: duration, lessonCompleted: lessonCompleted)
                    lessonsList.append(newLesson)

                }
            
                let assesmentResponse = lessonResponse["assignmentResponse"] as? [String: Any]
                
                if(assesmentResponse != nil) {
                    print("inside assesment response")
                    guard let assesmentdetails = assesmentResponse else {return}

                    guard let assignmentId = assesmentdetails["assignmentId"] as? Int else {print("chapterCountErr1"); return}
                    guard let assignmentName = assesmentdetails["assignmentName"] as? String else {print("chapterCountErr2"); return}
                    guard let testDuration = assesmentdetails["testDuration"] as? Int else {print("hello");return}
                    guard let questionCount = assesmentdetails["questionCount"] as? Int else {print("chapterCountErr3"); return}
                    guard let grade = assesmentdetails["grade"] as? Int else {print("chapterCountErr4"); return}
                    let assesment = AssignmentResponse(assignmentId: assignmentId, assignmentName: assignmentName, testDuration: testDuration, questionCount: questionCount, grade: Int(grade))
                   
                    lessonsList.append(assesment)
               
                }
                let lessonResponse = LessonResponseList(chapterId: chapterId, chapterName: chapterName, chapterCompleted: chapterCompletionStatus, lessonList: lessonsList)
                self.listOfLessons.append(lessonResponse)
                
                
                

            }
            print(lessonResponseLists.count)
            print("after array")
            let courseChapter = CourseChapter(joinedCourse: joinedCourse, certificateResponse: nil, certificateGenerated: certificateGenerated, lessonResponseList: self.listOfLessons, courseContentResponse:CourseContentData )
            
            completion(courseChapter)
        } failure: {(error) in
            print(error)
        fail()
        }

    }
}
