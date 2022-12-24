//
//  EditProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
import UIKit
class EditProfileViewModel {
    var mainshared = mainViewModel.mainShared
    
    func updateProfileData(profileImage: UIImage,token: String, profiledata: ProfileData, completion: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let networkManager = NetWorkManager()
         let url = "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile"

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
        let boundary = "Boundary-\(UUID().uuidString)"
        let data = NSMutableData()
        let fieldName = "file"
        if let imageData = profileImage.jpegData(compressionQuality: 1) {

                      data.append("--\(boundary)\r\n".data(using: .utf8)!)

                      data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)

                      data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)

                      data.append(imageData)

                      data.append("\r\n".data(using: .utf8)!)

                  }


        networkManager.postData(url: url, requestMethod: "PATCH", profileImage: profileImage,  parameters: parameters,token: token, headers: nil) { (result,error)  in
            if(error != nil) {
                if result as? Int == 401 {
                    fail("unauthorized")
                }
                else {
                    completion()
                }
            } else {
                fail("cant load data")
            }
            
            
        }
    }
}


