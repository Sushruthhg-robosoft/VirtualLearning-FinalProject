//
//  categoriesViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 15/12/22.
//

import Foundation

class CategoryViewModel{
    
    var networkManger = NetWorkManager()
    var listofCategories = [Category]()
    var categoryDetails = [CategotyDetails]()
    var subCategoryDetails = [subCategory]()
    var featuredCourse = [HomeCourse]()
    
    
    func getCategories(token: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/categories") else{return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            self.listofCategories.removeAll()

            guard let apiData = data as? [Any] else {print("error in category 2"); return fail()}
            
            for categoryData in apiData{
                guard let categories = categoryData as? [String : Any] else {print("error in category 2"); return fail()}
                guard let categoryId = categories["categoryId"] as? Int else {print("error in category 3"); return fail()}
                guard let categoryName = categories["categoryName"] as? String else {print("error in category 4"); return fail()}
                guard let categoryImage = categories["categoryImage"] as? String else {print("error in category 5"); return fail()}
                
                let categoty = Category(categoryId: String(categoryId), categoryImage: categoryImage, categotyName: categoryName)
                self.listofCategories.append(categoty)
                
                completion()
            }
        } failure: { (error) in
            print("Fail")
        }
        
    }
    
    
    func getCategegoryDetailsById(token: String,categoryId: String,limit: String,page: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        guard let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/user/view/courses/started?categoryId=\(categoryId)&limit=5&page=1") else{return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else {print("error in category details 1"); return fail()}
            for categoryData in apiData{
                guard let firstData = categoryData as? [String:Any] else {print("error in category details 2"); return fail()}
                guard let categoryName = firstData["category_name"] as? String else {print("error in category details 3"); return fail()}
                guard let chapterCount = firstData["chapter_count"] as? Int else {print("error in category details 4"); return fail()}
                guard let courseId = firstData["course_id"] as? Int else {print("error in category details 5"); return fail()}
                guard let courseImage = firstData["courseThumbnail"] as? String else {print("error in category details 5"); return fail()}
                guard let courseName = firstData["course_name"] as? String else {print("error in category details 5"); return fail()}
                guard let videoLength = firstData["totalVideoLength"] as? Int else {print("error in category details 5"); return fail()}
                let category = CategotyDetails(categoryName: categoryName, chapterCount: String(chapterCount), courseId: String(courseId), courseImage: courseImage, courseName: courseName,courseDuration: String(videoLength))
                
                self.categoryDetails.append(category)
                
                
            }
            completion()
        } failure: { (fail) in
           
            print(fail)
        }

    }
    
    
    func getSubCategoryDetails(token: String,categoryId: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/user/view/subcategory?categoryId=\(categoryId)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else {print("error in subcategory details 1"); return fail()}
            for subCategoryDetails in apiData{
                guard let firstData = subCategoryDetails as? [String : Any] else {print("error in subcategory details 2"); return fail()}
                guard let subCatID = firstData["subCategoryId"] as? Int else {print("error in subcategory details 3"); return fail()}
                guard let subCategoryName = firstData["subCategoryName"] as? String else {print("error in subcategory details 4"); return fail()}
                
                let subcategory = subCategory(subCategoryId: String(subCatID), subCategotyName: subCategoryName)
                self.subCategoryDetails.append(subcategory)
            }
            
            completion()
        } failure: { (fail) in
            print(fail)
        }

    }
    
    func getFeaturedCourseDetails(categoryId: String,token: String,completion: @escaping([HomeCourse]) -> Void, fail: @escaping (String) -> Void){
        
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/featured-courses?categoryId=\(categoryId)&limit=100&page=1") else{return fail("url error")}
        
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
                self.featuredCourse.append(course)
            }

            completion(self.featuredCourse)
            
        } failure: { (error) in
            print(error)
            if error as? Int  == 401{
                print("fetch json error111111")
                fail("unauthorized")
            }
            fail("Cant Load Data")
        }
        
        
    }

}
