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
    
    func updateProfileData(profileImage: UIImage,token: String, profiledata: ProfileData, completion: @escaping () -> Void, fail: @escaping () -> Void) {
        let networkManager = NetWorkManager()
         let url = "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile"
//        var request = URLRequest(url: urL)
//        request.httpMethod = "PATCH"
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
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        let data = NSMutableData()
//        let fieldName = "file"
//        if let imageData = profileImage.jpegData(compressionQuality: 1) {
//
//                      data.append("--\(boundary)\r\n".data(using: .utf8)!)
//
//                      data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//
//                      data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//
//                      data.append(imageData)
//
//                      data.append("\r\n".data(using: .utf8)!)
//
//                  }
//
//        print(parameters)
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
//
//
//        request.setValue("Bearer \(mainshared.token)", forHTTPHeaderField: "Authorization")
//
        print(parameters)
        networkManager.postData(url: url, requestMethod: "PATCH", profileImage:profileImage,  parameters: parameters,token: token, headers: nil) { (result,error)  in
            print(result, "aaa")
        completion()
            
        }
    }
}


