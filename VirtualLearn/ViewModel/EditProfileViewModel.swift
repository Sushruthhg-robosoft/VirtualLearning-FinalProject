//
//  EditProfileViewModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
class EditProfileViewModel {
    let networkManager = NetWorkManager()
    

    
    func updateProfileData(profiledata: String, completion: @escaping () -> Void, fail: @escaping () -> Void) {
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/profile")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let parameters = [String: Any] [
//            "phoneNumber" = profiledata.
//        ]
        
            
            
            
            
            
        
        
        
    
    
}
}
