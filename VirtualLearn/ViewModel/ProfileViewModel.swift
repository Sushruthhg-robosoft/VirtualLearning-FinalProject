//
//  ProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 14/12/22.
//

import Foundation
class ProfileViewModel {
    let networkManager = NetWorkManager()
    var profileDataDetails = [ProfileData]()
    
    
    func getProfileData(token: String, completion: @escaping(ProfileData) -> Void, fail: @escaping (String) -> Void) {
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile") else{return fail("url error")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
            guard let profileData = data as? [String: Any] else { print("Error"); return fail("data error") }
            print(profileData)
            guard let userId = profileData["userId"] as? Int else{print("userId error");return fail("data error")}
             let  profilePicture = profileData["profilePic"] as? String
            guard let name = profileData["fullName"] as? String else{print("fullName error");return fail("data error")}
            guard let userName = profileData["userName"] as? String else{print("userName error");return fail("data error")}
            guard let emailId = profileData["emailId"] as? String else{print("emailId error");return fail("data error")}
            guard let phoneNumber = profileData["phoneNumber"] as? String else{print("phoneNumber error");return fail("data error")}
             let occupation = profileData["occupation"] as? String
             let dateOfBirth = profileData["dateOfBirth"] as? String
             let gender = profileData["gender"] as? String
            guard let coursesCompleted = profileData["numberOfCoursesCompleted"] as? Int else{print("coursesCompleted error");return fail("data error")}
            guard let chaptersCompleted = profileData["numberOfChaptersCompleted"] as? Int else{print("chaptersCompleted error");return fail("data error")}
            guard let testsAttempted = profileData["numberOfTestAttempted"] as? Int else{print("testAttempted error");return fail("data error")}
            let facebookLink = profileData["facebookLink"] as? String
            let twitterLink = profileData["twitterLink"] as? String
        
            let profiledata = ProfileData(userId: userId, profilePic: profilePicture, fullName: name, userName: userName, emailId: emailId, phoneNumber: phoneNumber, occupation: occupation, dateOfBirth: dateOfBirth, numberOfCoursesCompleted: coursesCompleted, numberOfChaptersCompleted: chaptersCompleted, numberOfTestsAttempted: testsAttempted, facebookLink: facebookLink, twitterLink: twitterLink, gender: gender)
            
            completion(profiledata)
            
                } failure: { failResult in
                    if failResult as? Int == 401{
                        print("in fetch data json error")
                        fail("unauthorized")
                    }
                    fail("can't load data")
                    
                }
        }
    
    func changePasswordForExistingUser(token: String, password: String, oldpassword: String, completion: @escaping () -> Void, fail: @escaping (String) -> Void) {
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/auth/reset-password") else{return fail("url error")}
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(password, forHTTPHeaderField: "password")
        request.setValue(oldpassword, forHTTPHeaderField: "oldPassword")
        networkManager.fetchData(request: request as URLRequest) { result in
            guard let response = result as? [String] else{return fail("data error")}
            if response[0] == "Password changed"
            {
                completion()
            }
            
        } failure: { failResult in
            
            print(failResult)
            if failResult as? Int == 401{
                print("in fetch data json error")
                fail("unauthorized")
            }
            fail("can't load data")
        }
    }
}
    



