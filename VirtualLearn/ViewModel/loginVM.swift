//
//  loginVM.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 11/12/22.
//

import Foundation

import UIKit

class LoginViewModel {
    
    func loginUser(userName: String, password: String) {
        let network = NetWorkManage()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let parameters: [String : Any] = [
            "username":userName,
            "password":password,
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        network.requestData(request: request){ result in

            let tokenData = result as? [String:Any]
            guard let token = tokenData?["token"] as? String else {return}
            guard let  tokenInfo =  token.data(using: .utf8) else {return}
            
            let keychain = KeyChain()
            keychain.saveData(userName: userName, data: tokenInfo)
            
            guard let receivedTokenData = keychain.loadData(userName: userName) else {return}
            guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else { return }
            print("unchained", receivedToken)
            
            
        }
        failure : { a in
            print(a)
        }
    }
    
    func resetPassword(mobileNumber: String, password: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
        let network = NetWorkManage()
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/forgot-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(mobileNumber, forHTTPHeaderField: "source")
        request.setValue(password, forHTTPHeaderField: "newPassword")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return}
                
                print(response[0])
            } failure: { failResult in
                print(failResult)
            }
        
    }
}
