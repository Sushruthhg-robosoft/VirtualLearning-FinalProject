//
//  TermaAndConditionsViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
import UIKit

class TermsOfServicesViewModel {
    let networkManager = NetWorkManager()
    var termsOfServicesData = [TermsOfServicesModel]()
    
    
    func gettermsofServicesContent(token: String, termsOfServicesId: String, completion: @escaping(TermsOfServicesModel) -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/terms-of-service")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
            guard let apiData = data as? [String: Any] else{ print("apiDataerror");return}
            guard let termsOfServiceId = apiData["termsOfServiceId"] as? Int else{ print("termsOfServiceId");return}
            guard let content = apiData["content"] as? String else{
                print("content error");return}
            
            let ServiceData = TermsOfServicesModel(termsOfServicesId: String(termsOfServiceId), content: content)
            
            self.termsOfServicesData.append(ServiceData)
        
            
            completion(ServiceData)
            
        } failure: { (error) in
            print(error)
            fail()
        }
        
    }
}


            
            
