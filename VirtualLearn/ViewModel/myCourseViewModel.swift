//
//  myCourseViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import Foundation


class myCourseViewModel{

    var netowkManeger = NetWorkManager()
    var ongoingCourses = [Course]()
    var completedCourses = [Course]()
    

    func getMycourseDetails(token: String,completion: @escaping() -> Void, fail: @escaping () -> Void){
        ongoingCourses.removeAll()
        completedCourses.removeAll()
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/myCourses") else{return fail()}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        netowkManeger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail()}
        
            for data in apiData {
                guard let apiDataJson = data as? [String: Any] else {return fail()}
                guard let completedChapter = apiDataJson["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error3");return fail()}
                guard let courseId = apiDataJson["course_id"] as? Int else{print("myCourseViewModel apiData array error4");return fail()}
                guard let courseImage = apiDataJson["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail()}
                guard let courseName = apiDataJson["course_name"] as? String else{print("myCourseViewModel apiData array error6");return fail()}
                guard let status = apiDataJson["status"] as? String else{print("myCourseViewModel apiData array error7");return fail()}
                guard let totalChapters = apiDataJson["chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail()}
                let ongoingStatus: Bool?
                
                if status == "Ongoing"{
                    
                    ongoingStatus = true
                }else{
                    ongoingStatus = false
                }
                
                let myCourseDetails = Course(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapter), totalNumberOfChapters: String(totalChapters), ongoingStatus: ongoingStatus!)
                
                if ongoingStatus!{
                    self.ongoingCourses.append(myCourseDetails)
                }
                else{
                    self.completedCourses.append(myCourseDetails)
                }
            }
            
            completion()
    
        } failure: { (error) in
            print(error)
            fail()
        }

    
    }
    
    
    
}
