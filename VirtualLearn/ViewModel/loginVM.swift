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
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/login") else {return fail()}
        let shared = mainViewModel.mainShared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(userName, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")
            network.requestData(request: request as URLRequest) { result in
                
                
                let tokenData = result as? [String:Any]
                
                guard let name = tokenData?["name"] as? String else {print("tokenData error1");return fail()}
                guard let token = tokenData?["token"] as? String else {print("tokenData error2");return fail()}
                guard let  tokenInfo =  token.data(using: .utf8) else {print("tokenData error3");return fail()}
                guard let id = tokenData?["id"] as? Int else{print("tokenData error4"); return fail()}
                shared.loginUserName = name
                self.storageManger.setUsernameData(useriD: String(id))
                
                let keychain = KeyChain()
                keychain.saveData(userId: String(id), data: tokenInfo)
                completion(token)
                
            } failure: { failResult in
                fail()
            }
    }
    
    func resetPassword(mobileNumber: String, password: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
        let network = NetWorkManager()
        guard let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/forgot-password") else {return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue(mobileNumber, forHTTPHeaderField: "source")
        request.setValue(password, forHTTPHeaderField: "newPassword")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return fail()}
                
                print(response[0])
            } failure: { failResult in
                print(failResult)
                fail()
            }
        
    }
    
    func checkphoneNumberForExsistingUser(mobileNumber: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
        let network = NetWorkManager()
        let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/check/phoneNumber")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(mobileNumber, forHTTPHeaderField: "phoneNumber")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return fail()}
                if(response[0] == "true") {
                    completion()
                }
                else {
                    fail()
                }
            } failure: { failResult in
                print(failResult)
                fail()
            }
        
    }
    
    func checkUserNameForExsistingUser(userName: String, completion: @escaping (String) ->Void, fail: @escaping(String) -> Void) {
        let network = NetWorkManager()
        guard let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/auth/login/check/userName") else {return fail(userName)}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(userName, forHTTPHeaderField: "userName")
            network.fetchData(request: request as URLRequest) { result in
                
                guard let response = result as? [String] else {return fail(userName)}
                
                if(response[0] == "true") {
                    completion(userName)
                }
                else {
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
            guard let url = URL(string:"https://app-virtuallearning-221207091853.azurewebsites.net/user/view/fullName") else{return fail()}
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(authId, forHTTPHeaderField: "authId")
            network.fetchData(request: request) { (data) in
                print("yes")
                guard let name = data as? [String] else{print("data error");return fail()}
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
