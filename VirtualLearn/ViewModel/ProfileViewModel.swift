//
//  ProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 14/12/22.
//

import Foundation
class ProfileViewModel {
//    static var shared = ProfileViewModel()
    let networkManager = NetWorkManager()
    var profileDataDetails = [ProfileData]()
    
    
    func getProfileData(token: String, completion: @escaping(ProfileData) -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
            guard let profileData = data as? [String: Any] else { print("Error"); return }
            print(profileData)
            guard let userId = profileData["userId"] as? Int else{print("userId error");return}
             let  profilePicture = profileData["profilePic"] as? String
//            print(profilePicture)
            guard let name = profileData["fullName"] as? String else{print("fullName error");return}
            guard let userName = profileData["userName"] as? String else{print("userName error");return}
            guard let emailId = profileData["emailId"] as? String else{print("emailId error");return}
            guard let phoneNumber = profileData["phoneNumber"] as? String else{print("phoneNumber error");return}
             let occupation = profileData["occupation"] as? String
             let dateOfBirth = profileData["dateOfBirth"] as? String
            guard let coursesCompleted = profileData["numberOfCoursesCompleted"] as? Int else{print("coursesCompleted error");return}
            guard let chaptersCompleted = profileData["numberOfChaptersCompleted"] as? Int else{print("chaptersCompleted error");return}
            guard let testsAttempted = profileData["numberOfTestAttempted"] as? Int else{print("testAttempted error");return}
            let facebookLink = profileData["facebookLink"] as? String
            let twitterLink = profileData["twitterLink"] as? String
        
            let profiledata = ProfileData(userId: userId, profilePic: profilePicture, fullName: name, userName: userName, emailId: emailId, phoneNumber: phoneNumber, occupation: occupation, dateOfBirth: dateOfBirth, numberOfCoursesCompleted: coursesCompleted, numberOfChaptersCompleted: chaptersCompleted, numberOfTestsAttempted: testsAttempted, facebookLink: facebookLink, twitterLink: twitterLink)
            
            completion(profiledata)
            
                } failure: { error in
            print(error)
                }
        }
    
    func changePasswordForExistingUser(token: String, password: String, oldpassword: String, completion: @escaping () -> Void, fail: @escaping () -> Void) {
       let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/reset-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(password, forHTTPHeaderField: "password")
        request.setValue(oldpassword, forHTTPHeaderField: "oldPassword")
        networkManager.fetchData(request: request as URLRequest) { result in
            guard let response = result as? [String] else{return}
            if response[0] == "Password changed"
            {
                completion()
            }
            
        } failure: { failResult in
            fail()
            print(failResult)
        }
    }
}
    



