//
//  chaptersViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit

class ChaptersViewModel {
    
    let networkManeger = NetWorkManager()
    
    func getChapters(courseId: String,completion: @escaping(String) -> Void, fail: @escaping () -> Void) {
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/chapter?courseId=18")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request) { data in
            
//            print(data)
            
            guard let apiData = data as? [String:Any] else {print("apiDataerr");return}
            
            guard let joinedCourse = apiData["joinedCourse"] as? Bool else{print("joinedCourseErr");return}
            guard let certificateResponse = apiData["certificateResponse"] as? Certificate else{print("certificaterespErr");return}
            guard let certificateGenerated = apiData["certificateGenerated"] as? Bool else{print("certificateGeneratedErr"); return}
            guard let courseContentResponse = apiData["courseContentResponse"] as? [String : Int] else{print("courseContentResponseErr"); return}
            
            
            print(joinedCourse)
            print(certificateResponse)
            print(certificateGenerated)
            print(courseContentResponse)
            
            
        } failure: {(error) in
            print(error)
        
        }

    }
}
