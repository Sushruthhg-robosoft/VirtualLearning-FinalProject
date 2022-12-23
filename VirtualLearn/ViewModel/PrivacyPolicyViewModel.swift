//
//  PrivacyPolicyViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
import UIKit

class PrivacyPolicyViewModel {
    
    let networkManager = NetWorkManager()
    var privacyPolicyData = [PrivacyPolicyModel]()
    
    
    func getprivacyPolicyContent(privacyPolicyId: String, completion: @escaping(PrivacyPolicyModel) -> Void, fail: @escaping () -> Void) {
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/view/privacy-policy") else{return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        networkManager.fetchDataJson(request: request) { data in
            guard let apiData = data as? [String: Any] else{ print("apiDataerror");return fail()}
            guard let policyId = apiData["privacyPolicyId"] as? Int else{ print("privacyPolicyIderror");return fail()}
            guard let content = apiData["content"] as? String else{
                print("content error");return fail()}
            
            let PolicyData = PrivacyPolicyModel(privacyPolicyId: String(policyId), content: content)
            
            self.privacyPolicyData.append(PolicyData)
        
            
            completion(PolicyData)
            
        } failure: { (error) in
            print(error)
            fail()
        }
        
    }
}


            
            




        
        
        
   
