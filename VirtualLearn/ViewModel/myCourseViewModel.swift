//
//  myCourseViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import Foundation

class myCourseViewModel{

    var netowkManeger = NetWorkManager()
    var ongoingCourses = [myCourse]()
    var completedCourses = [myCourse]()
    
    let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdW1hbnRocHJhYmh1IiwiZXhwIjoxNjcxMDI3MDAxLCJpYXQiOjE2NzA5OTEwMDF9.eD99V-Mat-m3XbiIdt6y_Bm0IGTYYcVsNz2HXRcPomd4CeZwdmBlmlZxxl_gvyzSS6U34GYPIm8D4AxypeefSg"
    
    
    func getMycourseDetails(completion: @escaping() -> Void, fail: @escaping () -> Void){
        ongoingCourses.removeAll()
        completedCourses.removeAll()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/myCourses")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        netowkManeger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            guard let apiDataJson = apiData[0] as? [String:Any] else{print("myCourseViewModel apiData array error2");return}
            guard let completedChapter = apiDataJson["chapter_count"] as? Int else{print("myCourseViewModel apiData array error3");return}
            guard let courseId = apiDataJson["course_id"] as? Int else{print("myCourseViewModel apiData array error4");return}
            guard let courseImage = apiDataJson["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
            guard let courseName = apiDataJson["course_name"] as? String else{print("myCourseViewModel apiData array error6");return}
            guard let status = apiDataJson["status"] as? String else{print("myCourseViewModel apiData array error7");return}
            guard let totalChapters = apiDataJson["total_no_of_chapters"] as? Int else{print("myCourseViewModel apiData array error7");return}
            let ongoingStatus: Bool?
            
            if status == "Ongoing"{
                
                ongoingStatus = true
            }else{
                ongoingStatus = false
            }
            
            let myCourseDetails = myCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapter), totalNumberOfChapters: String(totalChapters), ongoingStatus: ongoingStatus!)
            
            if ongoingStatus!{
                self.ongoingCourses.append(myCourseDetails)
            }
            else{
                self.completedCourses.append(myCourseDetails)
            }
            
            completion()
    
        } failure: { (error) in
            print(error)
            fail()
        }

    
    }
}
