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
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/chapter?courseId=18")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request) { data in
            
//            print(data)
            
            guard let apiData = data as? [String:Any] else {print("apiDataerr");return}
            
            guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return}
//            guard let certificateResponse = apiData["certificateResponse"] as? Certificate? else{print("certificaterespErr");return}
            guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratedErr"); return}
            
            let courseChapter = CourseChapter(joinedCourse: joinedCourse, certificateResponse: nil, certificateGenerated: certificateGenerated)
            self.courseChapter.append(courseChapter)
            
            
            
            
            guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return}
            guard let courseId = courseContentResponse["courseId"] else{print("courseIdErr"); return}
            guard let chapterCount = courseContentResponse["chapterCount"] else{print("chapterCountErr"); return}
            guard let lessonCount = courseContentResponse["lessonCount"] else{print("lesscountErr"); return}
            guard let moduleTest = courseContentResponse["moduleTest"] else{print("moduleTestErr"); return}
            guard let totalVideoLength = courseContentResponse["totalVideoLength"] else{print("totalVideoLengthErr"); return}
            
            let CourseContentData = CourseContentResponse(courseId: courseId, chapterCount: chapterCount, lessonCount: lessonCount, moduleTest: moduleTest, totalVideoLength: totalVideoLength)
            self.courseContentResponse.append(CourseContentData)
            
            
            
            guard let LessonResponse = apiData["lessonResponseList"] as? [[String : Any]] else{print("lessonResponseListErr"); return}
            
            for lessonResponseList in LessonResponse {
                
                guard let chapterName = lessonResponseList["chapterName"] as? String else{print("chapterNameErr"); return}
                guard let chapterId = lessonResponseList["chapterId"] as? Int else{print("chapterIdErr"); return}
                guard let chapterCompletionStatus = lessonResponseList["chapterCompleted"] as? Bool else{print("chapterStatusErr"); return}
//                guard let assignmentResponse = lessonResponseList["assignmentResponse"] as? LessonResponseList else{print("assignmentResponseErr"); return}
                
                
                let lessonResponseData = LessonResponseList(chapterId: chapterId, chapterName: chapterName, chapterCompleted: chapterCompletionStatus, assignmentResponse: nil)
                
                self.lessonResponseList.append(lessonResponseData)
                
                guard let lessonList = lessonResponseList["lessonList"] as? [Any] else{print("lessonListErr"); return}
                
                
                print(chapterName,chapterId,chapterCompletionStatus,lessonList )
            }
            
            
            
            
            
            print(joinedCourse)
//            print(certificateResponse)
            print(certificateGenerated)
            print(courseContentResponse)
            print(courseId)
            print(chapterCount)
            print(lessonCount)
            print(moduleTest)
            print(totalVideoLength)
            print(LessonResponse)
            
        } failure: {(error) in
            print(error)
        
        }

    }
}
