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
    func getCategories(token: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/categories")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            self.listofCategories.removeAll()
            guard let apiData = data as? [Any] else {print("error in category 2"); return}
            
            for categoryData in apiData{
                guard let categories = categoryData as? [String : Any] else {print("error in category 2"); return}
                guard let categoryId = categories["categoryId"] as? Int else {print("error in category 3"); return}
                guard let categoryName = categories["categoryName"] as? String else {print("error in category 4"); return}
                guard let categoryImage = categories["categoryImage"] as? String else {print("error in category 5"); return}
                
                let categoty = Category(categoryId: String(categoryId), categoryImage: categoryImage, categotyName: categoryName)
                self.listofCategories.append(categoty)
//                print(self.listofCategories.count)
                
                completion()
            }
        } failure: { (error) in
            print("Fail")
        }
        
    }
    
    
    func getCategegoryDetailsById(token: String,categoryId: String,limit: String,page: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/user/view/category/course?categoryId=1&limit=5&page=1")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            guard let apiData = data as? [Any] else {print("error in category details 1"); return}
            for categoryData in apiData{
                guard let firstData = categoryData as? [String:Any] else {print("error in category details 2"); return}
                guard let categoryName = firstData["category_name"] as? String else {print("error in category details 3"); return}
                guard let chapterCount = firstData["chapter_count"] as? Int else {print("error in category details 4"); return}
                guard let courseId = firstData["course_id"] as? Int else {print("error in category details 5"); return}
                guard let courseImage = firstData["course_image"] as? String else {print("error in category details 5"); return}
                guard let courseName = firstData["course_name"] as? String else {print("error in category details 5"); return}
                guard let videoLength = firstData["totalVideoLength"] as? Int else {print("error in category details 5"); return}
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
            guard let apiData = data as? [Any] else {print("error in subcategory details 1"); return}
            for subCategoryDetails in apiData{
                guard let firstData = subCategoryDetails as? [String : Any] else {print("error in subcategory details 2"); return}
                guard let subCatID = firstData["subCategoryId"] as? Int else {print("error in subcategory details 3"); return}
                guard let subCategoryName = firstData["subCategoryName"] as? String else {print("error in subcategory details 4"); return}
                
                let subcategory = subCategory(subCategoryId: String(subCatID), subCategotyName: subCategoryName)
                self.subCategoryDetails.append(subcategory)
            }
            
            completion()
            //print(apiData)
        } failure: { (fail) in
            print(fail)
        }

    }
    
    
}
