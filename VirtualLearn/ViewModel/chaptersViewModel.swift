//
//  chaptersViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit
import Photos

class ChaptersViewModel {
    
    let networkManeger = NetWorkManager()
    var listOfLessons = [LessonResponseList]()
    
    func getChapters(token: String, courseId: String,completion: @escaping(CourseChapter) -> Void, fail: @escaping (String) -> Void) {
            
            var expandStatus = 0
            var videoPlay = 0
            guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/chapter?courseId=\(courseId)") else{ return fail("url Error")}
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            listOfLessons.removeAll()
            networkManeger.fetchDataJson(request: request) { data in
                
                guard let apiData = data as? [String:Any] else {print("apiDataerr");return fail("data Error")}

                guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return fail("data Error")}

                
                guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return fail("data Error")}
                guard let courseId = courseContentResponse["courseId"] else{print("courseIdErr"); return fail("data Error")}
                guard let chapterCount = courseContentResponse["chapterCount"] else{print("chapterCountErr"); return fail("data Error")}
                guard let lessonCount = courseContentResponse["lessonCount"] else{print("lesscountErr"); return fail("data Error")}
                guard let moduleTest = courseContentResponse["moduleTest"] else{print("moduleTestErr"); return fail("data Error")}
                guard let totalVideoLength = courseContentResponse["totalVideoLength"] else{print("totalVideoLengthErr"); return fail("data Error")}
                
                let CourseContentData = CourseContentResponse(courseId: courseId, chapterCount: chapterCount, lessonCount: lessonCount, moduleTest: moduleTest, totalVideoLength: totalVideoLength)
                
                guard let lessonResponseLists = apiData["lessonResponseList"] as? [[String:Any]] else{print("lessonResponseListErr"); return fail("data Error")}
                var lessonsList = [Any]()
                for lessonResponse in lessonResponseLists {
                    lessonsList.removeAll()
                    guard let chapterName = lessonResponse["chapterName"] as? String else{print("chapterNameErr1"); return fail("data Error")}
                    guard let chapterId = lessonResponse["chapterId"] as? Int else{print("chapterIdErr2"); return fail("data Error")}
                    guard let chapterNumber = lessonResponse["chapterNumber"] as? Int else{print("chapterIdErr3"); return fail("data Error")}
                    guard let chapterCompletionStatus = lessonResponse["chapterCompleted"] as? Bool else{print("chapterStatusErr4"); return fail("data Error")}
                    
                    guard let chapterList = lessonResponse["lessonList"] as? [[String:Any]] else{print("chapterlist Errrpr"); return fail("data Error")}

                    for lesson in chapterList {
                        guard let lessonId = lesson["lessonId"] as? Int else {return fail("data Error")}
                        guard let lessonNumber = lesson["lessonNumber"] as? Int else {return fail("data Error")}
                        guard let lessonName = lesson["lessonName"] as? String else {return fail("data Error")}
                        guard let videoLink = lesson["videoLink"] as? String else {return fail("data Error")}
                        guard let duration = lesson["duration"] as? Int else {return fail("data Error")}
                        guard let durationCompleted = lesson["durationCompleted"] as? Int else {return fail("data Error")}
                        guard let lessonCompleted = lesson["lessonCompleted"] as? Bool else {return fail("data Error")}
                        
                        let newLesson = LessonList(lessonId: lessonId, lessonNumber: String(lessonNumber), lessonName: lessonName, durationCompleted: durationCompleted, videoLink: videoLink, duration: duration, lessonCompleted: lessonCompleted)
                        if(!lessonCompleted) {
                            if(videoPlay == 0) { newLesson.nextPlay = true; videoPlay = 1 }
                        }
                        lessonsList.append(newLesson)

                    }
                
                    let assesmentResponse = lessonResponse["assignmentResponse"] as? [String: Any]
                    
                    if(assesmentResponse != nil) {
                        print("inside assesment response")
                        guard let assesmentdetails = assesmentResponse else {return}

                        guard let assignmentId = assesmentdetails["assignmentId"] as? Int else {print("chapterCountErr1"); return fail("data Error")}
                        guard let assignmentName = assesmentdetails["assignmentName"] as? String else {print("chapterCountErr2"); return fail("data Error")}
                        guard let testDuration = assesmentdetails["testDuration"] as? Int else {print("hello");return fail("data Error")}
                        guard let questionCount = assesmentdetails["questionCount"] as? Int else {print("chapterCountErr3"); return fail("data Error")}
                        guard let assignmentCompleted = assesmentdetails["assignmentCompleted"] as? Bool else {print("chapterCountErr4"); return fail("data Error")}
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
                
                guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratedrr"); return fail("data Error")}
                if(certificateGenerated) {
                    guard let certificateData = apiData["certificateResponse"] as? [String:Any] else{print("certificateResponseerr"); return fail("data Error")}
                    
                    guard let joinedDate = certificateData["joinDate"] as? String else {print("err1"); return fail("data Error")}
                    guard let completedDate = certificateData["completedDate"] as? String else {print("err2"); return fail("data Error")}
                    guard let completionDuration = certificateData["completionDuration"] as? String else {print("err3"); return fail("data Error")}
                    guard let grade = certificateData["grade"] as? Int else {print("err4"); return fail("data Error")}
                    guard let certificateLink = certificateData["certificateLink"] as? String else {print("err5"); return fail("data Error")}
                    
                    let certificate = Certificate(joinedData: joinedDate, completedDate: completedDate, completionDuration: completionDuration, grade: grade, certificateLink: certificateLink)
                    certificateResponse = certificate
                }
                
                let courseChapter = CourseChapter(joinedCourse: joinedCourse, certificateResponse: certificateResponse, certificateGenerated: certificateGenerated, lessonResponseList: self.listOfLessons, courseContentResponse:CourseContentData )
                
                completion(courseChapter)
            } failure: {(failerror) in
                print(failerror)
                if failerror as? Int  == 401{
                    print("fetch json error111111")
                    fail("unauthorized")
                }
                fail("Cant Load Data")
            }

        }
    
    func downloadCertificate(imageUrl: String) {
        guard let imageURL = URL(string: imageUrl) else { return }
        
        let session = URLSession.shared
            let task = session.dataTask(with: imageURL) { data, response, error in
                if error != nil || data == nil {
                    print("Error: \(String(describing: error?.localizedDescription))")
                    return
                }
                guard let imageData = data else {return}
                let image = UIImage(data: imageData)
                guard let imagePhoto = image else {return}
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: imagePhoto)
                }, completionHandler: { success, error in
                    if success {
                        print("Successfully saved image to photo library.")
                    } else {
                        print("Error saving image to photo library: \(String(describing: error))")
                    }
                })
            }
            task.resume()
        }
        
        
}
