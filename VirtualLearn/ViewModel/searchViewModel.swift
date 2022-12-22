//
//  searchViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 20/12/22.
//

import Foundation

class SearchViewModel {
    
    let networkManeger = NetWorkManager()
    
    
    var duration = [[String : Int]]()
    var searchOption = ""
    var categories = [Int]()
    var searchResult = [Search]()
    
    var topSearches = [String]()
    
    
    func getSearchResult(completion: @escaping ([Search]) -> (), fail: @escaping (Bool) ->()){
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/search")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.searchResult.removeAll()
        let parameters: [String : Any] = [
            
            "searchOption" : searchOption,
            "categories" : categories,
            "durationRequestList": duration
        ]
        print(parameters)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        networkManeger.fetchDataJson(request: request, completion: { (result) in
            
            
            guard let searchdata = result as? [[String : Any]] else{print("searchDataErr"); return}
            
            if searchdata.count == 0 {
                completion(self.searchResult)
            }else{
                for searchData in searchdata{
                    print("sjgknsjgdbawghoikjfhuhgj")
                    guard let courseId = searchData["courseId"] as? Int else{print("courseIdErr"); return}
                    guard let courseName = searchData["courseName"] as? String else{print("courseNameErr"); return}
                    guard let categoryName = searchData["categoryName"] as? String else{print("categoryNameErr"); return}
                    guard let noOfChapters = searchData["noOfChapters"] as? Int else{print("noOfChaptersErr"); return}
                    guard let courseImage = searchData["courseImage"] as? String else{print("courseImageErr"); return}
                    
                    let search = Search(courseId: courseId, courseName: courseName, categoryName: categoryName, noOfChapters: noOfChapters, courseImage: courseImage)
                    
                    self.searchResult.append(search)
                    completion(self.searchResult)
                }
            }
            
            
        }, failure: { (a) in
            print(a)
        })
    }
    
    func getTopSearches(completion: @escaping (Bool) -> (), fail: @escaping (Bool) ->()){
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/topSearches")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkManeger.fetchDataJson(request: request, completion: { (result) in
            
            guard let topSearch = result as? [String] else{print("topsearchErr"); return}
            for i in topSearch {
                self.topSearches.append(i)
            }
            completion(true)
            
            
            
        }, failure: { (a) in
            print(a)
        })
    }
    
}
