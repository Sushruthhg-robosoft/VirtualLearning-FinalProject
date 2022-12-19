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
    
    
    func getprivacyPolicyContent(privacyPolicyId: String, completion: @escaping() -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/privacy-policy")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer\(token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
            guard let apiData = data as? [String: Any] else{ print("apiDataerror"); return}
            guard let policyId = apiData["privacyPolicyId"] as? Int else{ print("privacyPolicyIderror"); return}
            guard let content = apiData["content"] as? String else{
                print("content error"); return}
            
            let PolicyData = PrivacyPolicyModel(privacyPolicyId: String(policyId), content: content)
            
            self.privacyPolicyData.append(PolicyData)
        
            
            completion()
            
        } failure: { (error) in
            print(error)
            fail()
        }
        
    }
}


            
            




        
        
        
   
