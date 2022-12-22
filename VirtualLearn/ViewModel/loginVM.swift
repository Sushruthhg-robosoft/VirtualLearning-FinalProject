//
//  loginVM.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 11/12/22.
//

import Foundation

import UIKit

class LoginViewModel {
    
    private var storageManger = StorageManeger.shared
    var user : String?
    func loginUser(userName: String, password: String, completion: @escaping (String) -> Void, fail: @escaping () -> Void) {
        let network = NetWorkManager()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/login")!
        let shared = mainViewModel.mainShared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(userName, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")
            network.requestData(request: request as URLRequest) { result in
                
                
                let tokenData = result as? [String:Any]
                
                guard let name = tokenData?["name"] as? String else {print("tokenData error1");return}
                guard let token = tokenData?["token"] as? String else {print("tokenData error2");return}
                guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return}
                guard let id = tokenData?["id"] as? Int else{print("tokenData error4"); return}
                shared.loginUserName = name
                self.storageManger.setUsernameData(useriD: String(id))
                
                let keychain = KeyChain()
                keychain.saveData(userId: String(id), data: tokenInfo)
                
//                guard let receivedTokenData = keychain.loadData(userId: String(id)) else {return}
//                guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else { return }
//                print("token",receivedToken)
                completion(token)
                
            } failure: { failResult in
                fail()
            }
    }
    
    func resetPassword(mobileNumber: String, password: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
        let network = NetWorkManager()
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
    
    func checkphoneNumberForExsistingUser(mobileNumber: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
        let network = NetWorkManager()
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/check/phoneNumber")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(mobileNumber, forHTTPHeaderField: "phoneNumber")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return}
                
                if(response[0] == "true")
                {
                    completion()
                }
                else
                {
                    fail()
                }
            } failure: { failResult in
                print(failResult)
                fail()
            }
        
    }
    
    func checkUserNameForExsistingUser(userName: String, completion: @escaping (String) ->Void, fail: @escaping(String) -> Void) {
        let network = NetWorkManager()
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/login/check/userName")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(userName, forHTTPHeaderField: "userName")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return}
                
                if(response[0] == "true")
                {
                    completion(userName)
                }
                else
                {
                    fail(userName)
                }
            } failure: { failResult in
                print(failResult)
                fail(userName)
            }
        
    }
    
    func getUserName(authId: String, completion: @escaping () ->Void, fail: @escaping() -> Void){
      
        if authId == "nouserName"{
            self.user = "Please Login"
        }
        else{
            let network = NetWorkManager()
            let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/user/view/fullName")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(authId, forHTTPHeaderField: "authId")
            network.fetchData(request: request) { (data) in
                print("yes")
                guard let name = data as? [String] else{print("data error");return}
                self.user = name[0]
                completion()
            } failure: { (failure) in
                print(failure)
                fail()
            }
        }


        
    }
    
    func logout(userId: String , token: String){
        print(userId,token)
        guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return}
        
        let keychain = KeyChain()
        keychain.deletePassword(userId: storageManger.authId(), data: tokenInfo)
    }
    
}
