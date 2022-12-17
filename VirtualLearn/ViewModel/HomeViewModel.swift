//
//  HomeViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 16/12/22.
//

import Foundation

class HomeViewModel {
    //var shared = mainViewModel.mainShared
    var banners = [String]()
    
    var networkManger = NetWorkManager()
    
    func getBanners(completion: @escaping([String]) -> Void, fail: @escaping () -> Void){
        banners.removeAll()
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/banner")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManger.fetchDataJson(request: request) { (data) in
            
            
            guard let apiData = data as? [Any] else {print("bannerError1");return}
            for bannerData in apiData{
                guard let bannerdetails = bannerData as? [String:Any] else {print("bannerError2");return}
                guard let bannerImage = bannerdetails["imageLink"] as? String else {print("bannerError3");return}
                self.banners.append(bannerImage)
                //print(self.banners.count)
                
            }
            completion(self.banners)
            
        } failure: { (error) in
            fail()
        }

    }
    
}
