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
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/search") else{ return fail(false)}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String : Any] = [
            
            "searchOption" : searchOption,
            "categories" : categories,
            "durationRequestList": duration
        ]
        print(parameters)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        self.searchResult.removeAll()

        networkManeger.fetchDataJson(request: request, completion: { (result) in
            self.searchResult.removeAll()

            
            guard let searchdata = result as? [[String : Any]] else{print("searchDataErr"); return fail(false)}
            
            if searchdata.count == 0 {
                completion(self.searchResult)
            }else{
                for searchData in searchdata{
                    print("sjgknsjgdbawghoikjfhuhgj")
                    guard let courseId = searchData["courseId"] as? Int else{print("courseIdErr"); return fail(false)}
                    guard let courseName = searchData["courseName"] as? String else{print("courseNameErr"); return fail(false)}
                    guard let categoryName = searchData["categoryName"] as? String else{print("categoryNameErr"); return fail(false)}
                    guard let noOfChapters = searchData["noOfChapters"] as? Int else{print("noOfChaptersErr"); return fail(false)}
                    guard let courseImage = searchData["courseImage"] as? String else{print("courseImageErr"); return fail(false)}
                    
                    let search = Search(courseId: courseId, courseName: courseName, categoryName: categoryName, noOfChapters: noOfChapters, courseImage: courseImage)
                    
                    self.searchResult.append(search)
                    completion(self.searchResult)
                }
            }
            
            
        }, failure: { (a) in
            print(a)
            if a as? Int == 401{
                print("fetch json error")
            }
            fail(false)
        })
    }
    
    func getTopSearches(completion: @escaping (Bool) -> (), fail: @escaping () ->()){
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/topSearches") else {return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkManeger.fetchDataJson(request: request, completion: { (result) in
            
            guard let topSearch = result as? [String] else{print("topsearchErr"); return fail()}
            for i in topSearch {
                self.topSearches.append(i)
            }
            completion(true)
            
            
            
        }, failure: { (error) in
            print(error)
            fail()
            
            
        })
    }
    func getAutoSearch(autoFill: String, completion: @escaping (String) -> (), fail: @escaping (Bool) ->()){
        
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/autoSearch?keyWord=\(autoFill)") else{ return fail(false)}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkManeger.fetchData(request: request, completion: { (result) in
            
            print(result)
            
            guard let autoSearchResult = result as? [String] else{print("autosearchErr"); return fail(false)}
            print(autoSearchResult[0])
            completion(autoSearchResult[0])
            
            
            
        }, failure: { (a) in
            print(a)
            fail(false)
        })
    }
    
}
