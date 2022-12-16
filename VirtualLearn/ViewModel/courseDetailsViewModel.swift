//
//  courseOverviewViewModel.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation
import UIKit

class courseDetailsViewModel {
    
    static var shared = courseDetailsViewModel()
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

    
}
