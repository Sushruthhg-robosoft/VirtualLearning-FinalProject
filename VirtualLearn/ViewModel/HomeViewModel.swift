//
//  HomeViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 16/12/22.
//

import Foundation

class HomeViewModel {
    //var shared = mainViewModel.mainShared
    var banners = [String]()
    var allCourse = [Course]()
    var networkManger = NetWorkManager()
    
    func getBanners(completion: @escaping([String]) -> Void, fail: @escaping () -> Void){
        banners.removeAll()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/banner")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManger.fetchDataJson(request: request) { (data) in
            
            
            guard let apiData = data as? [Any] else {print("bannerError1");return}
            for bannerData in apiData{
                guard let bannerdetails = bannerData as? [String:Any] else {print("bannerError2");return}
                guard let bannerImage = bannerdetails["imageLink"] as? String else {print("bannerError3");return}
                self.banners.append(bannerImage)
                //print(self.banners.count)
                
            }
            completion(self.banners)
            
        } failure: { (error) in
            fail()
        }

    }
    
    func getAllCourseDeatils(completion: @escaping([Course]) -> Void, fail: @escaping () -> Void){
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/courses?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            guard let apiDataJson = apiData[0] as? [String:Any] else{print("myCourseViewModel apiData array error2");return}
            guard let completedChapter = apiDataJson["chapter_count"] as? Int else{print("myCourseViewModel apiData array error3");return}
            guard let courseId = apiDataJson["course_id"] as? Int else{print("myCourseViewModel apiData array error4");return}
            guard let courseImage = apiDataJson["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
            guard let courseName = apiDataJson["course_name"] as? String else{print("myCourseViewModel apiData array error6");return}
            guard let totalChapters = apiDataJson["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error7");return}
            let ongoingStatus = false
                
            
            let myCourseDetails = Course(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapter), totalNumberOfChapters: String(totalChapters), ongoingStatus: ongoingStatus)
            self.allCourse.append(myCourseDetails)
            print(self.allCourse.count)
            completion(self.allCourse)
    
        } failure: { (error) in
            print(error)
            fail()
        }

    
    }
    
    
    
}
