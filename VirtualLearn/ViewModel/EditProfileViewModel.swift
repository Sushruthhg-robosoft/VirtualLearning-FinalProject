//
//  EditProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
class EditProfileViewModel {
    
    func updateProfileData(profiledata: ProfileData, completion: @escaping () -> Void, fail: @escaping () -> Void) {
        let networkManager = NetWorkManager()
        let url = "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile"
        
        let parameters: [String : Any] = [
            "fullName" : profiledata.fullName,
            "userName" : profiledata.userName,
            "phoneNumber" : profiledata.phoneNumber,
            "emailId" : profiledata.emailId,
            
            ]
        let header = [String:String]()
        networkManager.postData(url: url, requestMethod: "PATCH", parameters: parameters, headers: header) {(result, error) in
            
            
            
            
            
    
        }
        
}
}

