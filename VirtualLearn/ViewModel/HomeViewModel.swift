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
    func getBanners(token: String, completion: @escaping([String]) -> Void, fail: @escaping (String) -> Void){
        banners.removeAll()
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/banner") else{ return fail("url error")}
        print("outside")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManger.fetchDataJson(request: request) { (data) in
            
            
            
            guard let apiData = data as? [Any] else {print("bannerError1");return fail("data error")}
            for bannerData in apiData{
                guard let bannerdetails = bannerData as? [String:Any] else {print("bannerError2");return fail("data error")}
                guard let bannerImage = bannerdetails["imageLink"] as? String else {print("bannerError3");return fail("data error")}
                self.banners.append(bannerImage)
                
            }
            completion(self.banners)
            
        } failure: { (error) in
            
            fail("Cant Load Data")
        }
        
    }
    
    func getAllCourseDeatils(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping (String) -> Void){
        
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/courses?limit=100&page=1") else{return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
           self.allCourse.removeAll()
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("data error")}
            //print(apiData)
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return fail("data error")}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return fail("data error")}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return fail("data error")}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("data error")}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("data error")}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("data error")}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            if error as? Int  == 401{
                print("fetch json error111111")
                fail("unauthorized")
            }
            fail("Cant Load Data")
        }
        
        
    }
    
    
    func getPopularCourseDetails(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping (String) -> Void){
        allCourse.removeAll()
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/popularCourse?limit=100&page=1") else{return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("data error")}
            //print(apiData)
            
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return fail("data error")}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return fail("data error")}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return fail("data error")}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("data error")}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("data error")}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("data error")}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            if error as? Int  == 401{
                print("fetch json error111111")
                fail("unauthorized")
            }
            fail("Cant Load Data")
        }
    
    }
    
    func getNewestCourseDetails(token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping (String) -> Void){
        allCourse.removeAll()
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/newestCourse?limit=100&page=1") else{return fail("url Error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("data error")}
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return fail("data error")}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return fail("data error")}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return fail("data error")}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("data error")}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("data error")}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("data error")}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                let course = HomeCourse(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength))
                self.allCourse.append(course)
            }

            completion(self.allCourse)
            
        } failure: { (error) in
            print(error)
            if error as? Int  == 401{
                print("fetch json error111111")
                fail("unauthorized")
            }
            fail("Cant Load Data")
        }
    
    }
    
    func getPopularCourseCategory1Details(token: String,completion: @escaping([TopCourseCategory], String) -> Void, fail: @escaping (String) -> Void){
        
        print("getPopularCourseCategory1Details")
        topCourseCategory1.removeAll()
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/course/category1?limit=5&page=1") else{ return fail("url data")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("data error")}
            //print(apiData)
            var Id = ""
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return fail("data error")}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return fail("data error")}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return fail("data error")}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("data error")}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("data error")}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("data error")}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return fail("data error")}
                guard let lessonCount = allData["lesson_count"] as? Int else {print("lessonCountErr");return fail("data error")}
                guard let categoryId = allData["categoryId"] as? Int else {print("categotyIderror"); return fail("data error")}
                let course = TopCourseCategory(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength), lessonCount: String(lessonCount))
                self.topCourseCategory1.append(course)
                Id = String(categoryId)
            }

            completion(self.topCourseCategory1, Id)
            
        } failure: { (error) in
            print(error)
            fail("Cant Load Data")
        }
    
    }
    
    func getPopularCourseCategory2Details(token: String,completion: @escaping([TopCourseCategory], String) -> Void, fail: @escaping (String) -> Void){
        topCourseCategory2.removeAll()
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/course/category2?limit=5&page=1") else{ return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            print(data)
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("dataerror")}
            //print(apiData)
            var Id = ""
            for allCourseData in apiData{
                
                guard let allData = allCourseData as? [String: Any] else{print("myCourseViewModel apiData array error2");return fail("dataerror")}
                guard let courseId = allData["course_id"] as? Int else{print("myCourseViewModel apiData array error3");return fail("dataerror")}
                guard let courseName = allData["course_name"] as? String else{print("myCourseViewModel apiData array error4");return fail("dataerror")}
                guard let courseImage = allData["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("dataerror")}
                guard let categoryName = allData["category_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("dataerror")}
                guard let completedChapterCount = allData["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("dataerror")}
                guard let videoLength = allData["totalVideoLength"] as? Int else{print("myCourseViewModel apiData array error8");return fail("dataerror")}
                guard let totalnumberOfChapters = allData["chapter_count"] as? Int else{print("myCourseViewModel apiData array error8");return fail("dataerror")}
                guard let lessonCount = allData["lesson_count"] as? Int else {print("lessonCountErr");return fail("dataerror")}
                guard let categoryId = allData["categoryId"] as? Int else {print("categotyIderror"); return fail("data error")}
                let course = TopCourseCategory(courseId: String(courseId), courseImage: courseImage, courseName: courseName, completedCount: String(completedChapterCount), totalNumberOfChapters: String(totalnumberOfChapters), categoryName: categoryName, videoLength: String(videoLength), lessonCount: String(lessonCount))
                Id = String(categoryId)
                self.topCourseCategory2.append(course)
            }

            completion(self.topCourseCategory2, Id)
            
        } failure: { (error) in
            print(error)
            fail("Cant Load Data")
        }
    
    }
    
    
    func getOngoingCourseForHome(token: String,completion: @escaping() -> Void, fail: @escaping (String) -> Void){
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/ongoing-courses") else{return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            
            guard let apiData = data as? [Any] else{print("myCourseViewModel apiData array error1");return fail("dataerror")}
        
            for data in apiData {
                guard let apiDataJson = data as? [String: Any] else {return}
                guard let completedChapter = apiDataJson["completed_chapter_count"] as? Int else{print("myCourseViewModel apiData array error3");return fail("dataerror")}
                guard let courseId = apiDataJson["course_id"] as? Int else{print("myCourseViewModel apiData array error4");return fail("dataerror")}
                guard let courseImage = apiDataJson["course_image"] as? String else{print("myCourseViewModel apiData array error5");return fail("dataerror")}
                guard let courseName = apiDataJson["course_name"] as? String else{print("myCourseViewModel apiData array error6");return fail("dataerror")}
                guard let status = apiDataJson["status"] as? String else{print("myCourseViewModel apiData array error7");return fail("dataerror")}
                guard let totalChapters = apiDataJson["chapter_count"] as? Int else{print("myCourseViewModel apiData array error7");return fail("dataerror")}
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
            
        } failure: { (failerror) in
            print(failerror)
            fail("Cant Load Data")
        }

    }
    
    func getPersonalDetailsStatus(token: String,completion: @escaping(String) -> Void, fail: @escaping (String) -> Void){
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/complete-profile") else{return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchData(request: request) { (data) in
            let status = data
            guard let profileStaus = status as? [String] else{print("error in personale details 2");return}
            completion(profileStaus[0])
        } failure: { (error) in
            print(error)
            fail(error as! String)
        }

    }
    
}
