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
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/register/check/userName")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(userName, forHTTPHeaderField: "userName")
        
        network.fetchData(request: request){ data in
            
            let responseData = data as? [String]
            guard let response = responseData?[0]  else {
                return
            }
            print("sdfghjk",response)
            if(response == "true")
            {
                
                completion(true)
            }
            else
            {
                //alertmessage "User Already Exist"
                fail(false)
            }
            
            
        } failure: { data in
            fail(false)
            print(data)
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
             "phoneNumber":"+918152041105",
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
            completion(true)
        }
        failure : { a in
          print(a)
            fail(false)
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

