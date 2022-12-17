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
    var courseChapter = [CourseChapter]()
    var courseContentResponse = [CourseContentResponse]()
    var lessonResponseList = [LessonResponseList]()
    var lessonList = [LessonList]()
    
    func getChapters(courseId: String,completion: @escaping(String) -> Void, fail: @escaping () -> Void) {
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/chapter?courseId=3")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request) { [self] data in
            
            guard let apiData = data as? [String:Any] else {print("apiDataerr");return}

            guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return}
            guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratederr");return}

            print("certificateGenerated",certificateGenerated)
            
            guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return}
            guard let courseId = courseContentResponse["courseId"] else{print("courseIdErr"); return}
            guard let chapterCount = courseContentResponse["chapterCount"] else{print("chapterCountErr"); return}
            guard let lessonCount = courseContentResponse["lessonCount"] else{print("lesscountErr"); return}
            guard let moduleTest = courseContentResponse["moduleTest"] else{print("moduleTestErr"); return}
            guard let totalVideoLength = courseContentResponse["totalVideoLength"] else{print("totalVideoLengthErr"); return}
            
            let CourseContentData = CourseContentResponse(courseId: courseId, chapterCount: chapterCount, lessonCount: lessonCount, moduleTest: moduleTest, totalVideoLength: totalVideoLength)

            
            
            
            guard let LessonResponse = apiData["lessonResponseList"] as? [[String : Any]] else{print("lessonResponseListErr"); return}
            
            for lessonResponseList in LessonResponse {
                
                guard let chapterName = lessonResponseList["chapterName"] as? String else{print("chapterNameErr"); return}
                guard let chapterId = lessonResponseList["chapterId"] as? Int else{print("chapterIdErr"); return}
                guard let chapterCompletionStatus = lessonResponseList["chapterCompleted"] as? Bool else{print("chapterStatusErr"); return}
                
                guard let chapterList = lessonResponseList["lessonList"] as? [[String:Any]] else{print("chapterlist Errrpr"); return}
                
                for lesson in chapterList {
                    guard let lessonId = lesson["lessonId"] as? Int else {return}
                    guard let lessonName = lesson["lessonName"] as? String else {return}
                    guard let videoLink = lesson["videoLink"] as? String else {return}
                    guard let duration = lesson["duration"] as? Int else {return}
                    guard let lessonCompleted = lesson["lessonCompleted"] as? Bool else {return}
                    
                    let newLesson = LessonList(lessonId: lessonId, lessonName: lessonName, videoLink: videoLink, duration: duration, lessonCompleted: lessonCompleted)
                    self.lessonList.append(newLesson)
                    
                }
                print("after lesson")
                let assesmentResponse = lessonResponseList["assignmentResponse"] as? [String: Any]
//                guard let assesmentResponseExsist = assesmentResponse else {return}
                print("assesmentResponse",assesmentResponse)
                if(assesmentResponse != nil) {
                    guard let assesmentdetails = assesmentResponse else {return}
                    print(assesmentdetails)
                    guard let assignmentId = assesmentdetails["assignmentId"] as? Int else {return}
                    guard let assignmentName = assesmentdetails["assignmentName"] as? String else {return}
                    guard let testDuration = assesmentdetails["testDuration"] as? String else {return}
                    guard let questionCount = assesmentdetails["questionCount"] as? Int else {return}
                    guard let grade = assesmentdetails["grade"] as? Bool else {return}
                    
                    let assesment = AssignmentResponse(assignmentId: <#T##Int#>, assignmentName: <#T##String#>, testDuration: <#T##Int#>, questionCount: <#T##Int#>, grade: <#T##Int#>)
                }
//                print(assesmentResponseExsist)
                

            }
            
        } failure: {(error) in
            print(error)
        
        }

    }
}
