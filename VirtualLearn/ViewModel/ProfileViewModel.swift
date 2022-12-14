//
//  ProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 14/12/22.
//

import Foundation
class ProfileViewModel {
    static var shared = ProfileViewModel()
    let networkManager = NetWorkManager()
    let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdW1hbnRocHJhYmh1IiwiZXhwIjoxNjcxMDM2Mjg1LCJpYXQiOjE2NzEwMDAyODV9.r_-6vPg-9s8WrbcYQdIN9kInYJdUtQCv8NKtFw4nzEgCCTfGRMGTWpXmx3qQCXlEQ7I-Pid1htCLyQ3bR1cKbQ"
    
    func getProfileData(completion: @escaping() -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
            guard let profileData = data as? [[String: Any]] else { print("Error"); return }
            print(profileData)
            
        
        } failure: { error in
            print(error)
        }
    }
}
