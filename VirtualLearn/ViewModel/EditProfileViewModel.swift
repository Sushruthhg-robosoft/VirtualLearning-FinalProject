//
//  EditProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
class EditProfileViewModel {
    var mainshared = mainViewModel.mainShared
    
    func updateProfileData(token: String, profiledata: ProfileData, completion: @escaping () -> Void, fail: @escaping () -> Void) {
        let networkManager = NetWorkManager()
        let urL = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile")!
        var request = URLRequest(url: urL)
        request.httpMethod = "PATCH"
        let parameters: [String : Any] = [
            "fullName" : profiledata.fullName,
            "userName" : profiledata.userName,
            "phoneNumber" : profiledata.phoneNumber,
            "emailId" : profiledata.emailId,
            "occupation" : profiledata.occupation!,
            "gender" : profiledata.gender!,
            "dateOfBirth" : profiledata.dateOfBirth!,
            "twitterLink" : profiledata.twitterLink!,
            "facebookLink" : profiledata.facebookLink!,
            
        ]
        
        print(parameters)
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        request.setValue("Bearer \(mainshared.token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchData(request: request) { result in
        completion()
            
        } failure: { error in
            print(error)
        }
        
    }
}

