//
//  courseOverviewViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit

class courseDetailsViewModel {
    
    let networkManeger = NetWorkManager()
    
    func joinCourse(courseId: String, completion: @escaping(String) -> Void, fail: @escaping () -> Void){
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/notification?notificationId=\(courseId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchData(request: request){ data in
            
            print(data)
            guard let status = data as? [String] else{return}
            completion(status[0])
            
            
            
        } failure: {error in
            print(error)
        }
        
    }
    
    func courseOverView(courseId: String, completion: @escaping(String) -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/courseOverview?courseId=\(courseId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request){ data in
            guard let courseData = data as? [String: Any] else {return}
            
            guard let courseHeader = courseData["courseHeader"] as? [String: Any] else {return}
            
            
        
            
            
        } failure: {error in
            print(error)
        }
    }

    
}
