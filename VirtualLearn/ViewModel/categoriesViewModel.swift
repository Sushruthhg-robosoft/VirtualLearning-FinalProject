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
    
    func getCategories(token: String, completion: @escaping() -> Void, fail: @escaping () -> Void){
        listofCategories.removeAll()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/categories")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
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
            print(12345678,apiData)
        } failure: { (fail) in
            print(fail)
        }

    }
}
