//
//  HomeViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 16/12/22.
//

import Foundation

class HomeViewModel {
    var banners = [String]()
    var allCourse = [HomeCourse]()
    var topCourseCategory1 = [TopCourseCategory]()
    var topCourseCategory2 = [TopCourseCategory]()
    var networkManger = NetWorkManager()
    var ongoingCourses = [Course]()
    func getBanners(token: String, completion: @escaping([String]) -> Void, fail: @escaping () -> Void){
        banners.removeAll()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/banner")!
        print("outside")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManger.fetchDataJson(request: request) { (data) in
            
            
            
            guard let apiData = data as? [Any] else {print("bannerError1");return}
            for bannerData in apiData{
                guard let bannerdetails = bannerData as? [String:Any] else {print("bannerError2");return}
                guard let bannerImage = bannerdetails["imageLink"] as? String else {print("bannerError3");return}
                self.banners.append(bannerImage)
                
            }
            completion(self.banners)
            
        } failure: { (error) in
            print("banner failure")
            
            fail()
        }
        
    }
    
    func getAllCourseDeatils(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping () -> Void){
        
        allCourse.removeAll()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/courses?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            fail()
        }
        
        
    }
    
    
    func getPopularCourseDetails(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping () -> Void){
        allCourse.removeAll()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/popularCourse?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            //print(apiData)
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            fail()
        }
    
    }
    
    func getNewestCourseDetails(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping () -> Void){
        allCourse.removeAll()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/newestCourse?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            fail()
        }
    
    }
    
    func getPopularCourseCategory1Details(token: String,completion: @escaping([TopCourseCategory]) -> Void, fail: @escaping () -> Void){
        
        print("getPopularCourseCategory1Details")
        topCourseCategory1.removeAll()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/course/category1?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let lessonCount = allData["lesson_count"] as? Int else {print("lessonCountErr");return}
                let course = TopCourseCategory(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength), lessonCount: String(lessonCount))
                self.topCourseCategory1.append(course)
            }

            completion(self.topCourseCategory1)
            
        } failure: { (error) in
            print(error)
            fail()
        }
    
    }
    
    func getPopularCourseCategory2Details(token: String,completion: @escaping([TopCourseCategory]) -> Void, fail: @escaping () -> Void){
        topCourseCategory2.removeAll()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/course/category2?limit=5&page=1")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            print(data)
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return}
                guard let lessonCount = allData["lesson_count"] as? Int else {print("lessonCountErr");return}
                let course = TopCourseCategory(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength), lessonCount: String(lessonCount))
                self.topCourseCategory2.append(course)
            }

            completion(self.topCourseCategory2)
            
        } failure: { (error) in
            print(error)
            fail()
        }
    
    }
    
    
    func getOngoingCourseForHome(token: String,completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/ongoing-courses")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return}
        
            for data in apiData {
                guard let apiDataJson = data as? [String: Any] else {return}
                guard let completedChapter = apiDataJson["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error3");return}
                guard let courseId = apiDataJson["course_id"] as? Int else{print("myCourseViewModel apiData array error4");return}
                guard let courseImage = apiDataJson["course_image"] as? String else{print("myCourseViewModel apiData array error5");return}
                guard let courseName = apiDataJson["course_name"] as? String else{print("myCourseViewModel apiData array error6");return}
                guard let status = apiDataJson["status"] as? String else{print("myCourseViewModel apiData array error7");return}
                guard let totalChapters = apiDataJson["chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return}
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
                
                
                
            }
            completion()
            
        } failure: { (fail) in
            print(fail)
        }

    }
    
    
}
