//
//  categoriesViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 15/12/22.
//

import Foundation

class CategoryViewModel{
    
    var networkManger = NetWorkManager()
    
    func getCategories(completion: @escaping() -> Void, fail: @escaping () -> Void){
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/categories")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManger.fetchDataJson(request: request) { (data) in
            print(data)
        } failure: { (error) in
            print("Fail")
        }

    }
}
