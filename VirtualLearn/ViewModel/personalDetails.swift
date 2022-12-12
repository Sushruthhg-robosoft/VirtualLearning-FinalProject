//
//  personalDetails.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 09/12/22.
//

import Foundation

import UIKit

class PersonalData {
    
    func validatingUserName(userName: String, completion: @escaping (Bool) -> (), fail: @escaping (Bool) ->()) {
        
        let network = NetWorkManage()
        let url = "https://app-virtuallearning-221207091853.azurewebsites.net/auth/check/userName"
        let parameter = ["userName": userName]
        network.postData(url: url,requestMethod: "POST", parameters: parameter, headers: nil) { (data, error) in
            if(error == nil)
            {
                guard let response = data as? String  else {
                    return
                }
                print(response)
                if(response == "true")
                {
                   completion(true)
                }
                else
                {
                    fail(false)
                }
            }
            else
            {
                fail(false)
            }
           
        }
    }
    
    func registeringUser(user: NewUser, completion: @escaping (Bool) -> (), fail: @escaping (Bool) ->()) {
        
        let network = NetWorkManage()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/register")!
//        let parameter = ["userName": userName]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        let parameters: [String : Any] = [
            "emailId":user.email,
             "phoneNumber":"+917022011412",
             "authentication": [
                "userName" : user.userName,
                "password":user.password
                ],
            "fullName":user.fullName,
                "provider":"local"
        ]
       request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        network.fetchData(request: request){ result in
            print(result)
            
        }
        failure : { a in
          print(a)
        }
    }
    
    func assignCurrentRegisterValue(fullName: String, userName: String, email: String, password: String) -> NewUser {
        let currentUser = NewUser()
        currentUser.fullName = fullName
        currentUser.userName = userName
        currentUser.email = email
        currentUser.password = password
        return currentUser
    }
    
}
