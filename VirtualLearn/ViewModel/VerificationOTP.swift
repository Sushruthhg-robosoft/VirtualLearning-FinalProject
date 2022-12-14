//
//  viewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import Foundation

class VerificationOTP {
    
    func getOTP(mobileNumber: String) {
        let network = NetWorkManager()
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/verify-phone-number")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(mobileNumber, forHTTPHeaderField: "phoneNumber")
            network.fetchData(request: request as URLRequest) { result in
                guard let  response  = result as? String else  {
                    return
                }
                print(response)
            } failure: { failResult in
                print(failResult)
            }
    }
    
    func verifyOTP(mobileNumber: String, otp: String, completion:@escaping (Bool) -> (), fail: @escaping (Bool) -> ()) {
        
        let network = NetWorkManager()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/validate-otp")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(mobileNumber, forHTTPHeaderField: "phoneNumber")
        request.setValue(otp, forHTTPHeaderField: "otp")
        
            network.fetchData(request: request as URLRequest) { result in
                completion(true)
            } failure: { failResult in
                fail(false)
                print(failResult)
            }
    }
    
    func checkphoneNumberForNewUser(mobileNumber: String, completion: @escaping () ->Void, fail: @escaping() -> Void) {
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
    
    
    
    
    
}

