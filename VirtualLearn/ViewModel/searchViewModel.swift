//
//  searchViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 20/12/22.
//

import Foundation

class SearchViewModel {
    
    let networkManeger = NetWorkManager()

    
    func getSearchResult(completion: @escaping (Bool) -> (), fail: @escaping (Bool) ->()){
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/search")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let parameters: [String : Any] = [
            
            "searchOption" : "design"
//            "categories" : [1,2],
//            "durationRequestList":[["startDuration" : 5,"endDuration" : 10],["startDuration" : 15,"endDuration" : 20]]
        ]
        print(parameters)
       request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        networkManeger.fetchDataJson(request: request, completion: { (result) in
            print(result)
        }, failure: { (a) in
            print(a)
        })
    }
    
    
}
