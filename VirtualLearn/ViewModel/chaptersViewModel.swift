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
        
        var expandStatus = 0
        var videoPlay = 0
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/chapter?courseId=\(courseId)") else{ return fail()}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        listOfLessons.removeAll()
        networkManeger.fetchDataJson(request: request) { data in
            
            guard let apiData = data as? [String:Any] else {print("apiDataerr");return fail()}

            guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return fail()}

            
            guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return fail()}
            guard let courseId = courseContentResponse["courseId"] else{print("courseIdErr"); return fail()}
            guard let chapterCount = courseContentResponse["chapterCount"] else{print("chapterCountErr"); return fail()}
            guard let lessonCount = courseContentResponse["lessonCount"] else{print("lesscountErr"); return fail()}
            guard let moduleTest = courseContentResponse["moduleTest"] else{print("moduleTestErr"); return fail()}
            guard let totalVideoLength = courseContentResponse["totalVideoLength"] else{print("totalVideoLengthErr"); return fail()}
            
            let CourseContentData = CourseContentResponse(courseId: courseId, chapterCount: chapterCount, lessonCount: lessonCount, moduleTest: moduleTest, totalVideoLength: totalVideoLength)
            
            guard let lessonResponseLists = apiData["lessonResponseList"] as? [[String:Any]] else{print("lessonResponseListErr"); return fail()}
            var lessonsList = [Any]()
            for lessonResponse in lessonResponseLists {
                lessonsList.removeAll()
                guard let chapterName = lessonResponse["chapterName"] as? String else{print("chapterNameErr1"); return fail()}
                guard let chapterId = lessonResponse["chapterId"] as? Int else{print("chapterIdErr2"); return fail()}
                guard let chapterNumber = lessonResponse["chapterNumber"] as? Int else{print("chapterIdErr3"); return fail()}
                guard let chapterCompletionStatus = lessonResponse["chapterCompleted"] as? Bool else{print("chapterStatusErr4"); return fail()}
                
                guard let chapterList = lessonResponse["lessonList"] as? [[String:Any]] else{print("chapterlist Errrpr"); return fail()}

                for lesson in chapterList {
                    guard let lessonId = lesson["lessonId"] as? Int else {return fail()}
                    guard let lessonNumber = lesson["lessonNumber"] as? Int else {return fail()}
                    guard let lessonName = lesson["lessonName"] as? String else {return fail()}
                    guard let videoLink = lesson["videoLink"] as? String else {return fail()}
                    guard let duration = lesson["duration"] as? Int else {return fail()}
                    guard let lessonCompleted = lesson["lessonCompleted"] as? Bool else {return fail()}
                    
                    let newLesson = LessonList(lessonId: lessonId, lessonNumber: String(lessonNumber), lessonName: lessonName, videoLink: videoLink, duration: duration, lessonCompleted: lessonCompleted)
                    if(!lessonCompleted) {
                        if(videoPlay == 0) { newLesson.nextPlay = true; videoPlay = 1 }
                    }
                    lessonsList.append(newLesson)

                }
            
                let assesmentResponse = lessonResponse["assignmentResponse"] as? [String: Any]
                
                if(assesmentResponse != nil) {
                    print("inside assesment response")
                    guard let assesmentdetails = assesmentResponse else {return}

                    guard let assignmentId = assesmentdetails["assignmentId"] as? Int else {print("chapterCountErr1"); return fail()}
                    guard let assignmentName = assesmentdetails["assignmentName"] as? String else {print("chapterCountErr2"); return fail()}
                    guard let testDuration = assesmentdetails["testDuration"] as? Int else {print("hello");return fail()}
                    guard let questionCount = assesmentdetails["questionCount"] as? Int else {print("chapterCountErr3"); return fail()}
                    guard let assignmentCompleted = assesmentdetails["assignmentCompleted"] as? Bool else {print("chapterCountErr4"); return fail()}
                    let grade = assesmentdetails["grade"] as? Int
                    let assesment = AssignmentResponse(assignmentId: assignmentId, assinmentStatus: assignmentCompleted, assignmentName: assignmentName, testDuration: testDuration, questionCount: questionCount, grade: Int(grade ?? 0))
                    lessonsList.append(assesment)
               
                }
                let lessonResponse = LessonResponseList(chapterId: chapterId, chapterNumber: String(chapterNumber), chapterName: chapterName, chapterCompleted: chapterCompletionStatus, lessonList: lessonsList)
                if(!chapterCompletionStatus) {
                    if(expandStatus == 0){
                        lessonResponse.isExpandable = true
                        expandStatus = 1
                    }
                }
                self.listOfLessons.append(lessonResponse)
                
                
                

            }
            print(lessonResponseLists.count)
//            print("after array")
            var certificateResponse: Certificate?
            
            guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratedrr"); return fail()}
            if(certificateGenerated) {
                guard let certificateData = apiData["certificateResponse"] as? [String:Any] else{print("certificateResponseerr"); return fail()}
                
                guard let joinedDate = certificateData["joinDate"] as? String else {print("err1"); return fail()}
                guard let completedDate = certificateData["completedDate"] as? String else {print("err2"); return fail()}
                guard let completionDuration = certificateData["completionDuration"] as? String else {print("err3"); return fail()}
                guard let grade = certificateData["grade"] as? Int else {print("err4"); return fail()}
                guard let certificateLink = certificateData["certificateLink"] as? String else {print("err5"); return fail()}
                
                let certificate = Certificate(joinedData: joinedDate, completedDate: completedDate, completionDuration: completionDuration, grade: grade, certificateLink: certificateLink)
                certificateResponse = certificate
            }
            
            let courseChapter = CourseChapter(joinedCourse: joinedCourse, certificateResponse: certificateResponse, certificateGenerated: certificateGenerated, lessonResponseList: self.listOfLessons, courseContentResponse:CourseContentData )
            
            completion(courseChapter)
        } failure: {(error) in
            print(error)
        fail()
        }

    }
}
