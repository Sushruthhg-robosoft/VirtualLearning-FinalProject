//
//  notificationViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 13/12/22.
//

import Foundation
class NotificationViewModel{
    
    static var shared = NotificationViewModel()
    let networkManeger = NetWorkManager()
    var notifications = [Notification]()
    var count = 0
    
   // let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdW1hbnRocHJhYmh1IiwiZXhwIjoxNjcxMDI3MDAxLCJpYXQiOjE2NzA5OTEwMDF9.eD99V-Mat-m3XbiIdt6y_Bm0IGTYYcVsNz2HXRcPomd4CeZwdmBlmlZxxl_gvyzSS6U34GYPIm8D4AxypeefSg"
    
    
    func getNotificationCount(token: String,completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        print("inside get notification")
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/notificationCount")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        networkManeger.fetchDataJson(request: request) { data in
            
            guard let notificationCount = data as? Int else {print("countErr");return}
            //guard let Count = Int(notificationCount[0]) else {return}
            print("notificaton Count",notificationCount)
            self.count = notificationCount
            completion()
        } failure: { (error) in
            print(error)
            fail()
        }
        
    }
    
    
    func getNotifications(token: String, limit: String,page: String,completion: @escaping() -> Void, fail: @escaping () -> Void){
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/notification?limit=\(limit)&page=\(page)")!
        
        notifications.removeAll()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchDataJson(request: request) { [self] data in
            guard let apiData = data as? [Any] else {print("apiDataerr");return}
            guard let allData = apiData as? [[String:Any]] else {print("allDataerr");return}
            
            
            for notificationData in allData{
                                
                var read:Bool?
                guard let reciever = notificationData["notification_id"] as? Int else{print("notification data parsing error1");return}
                guard let notificationImage = notificationData["notification_image"] as? String else{print("notification data parsing error2");return}
                guard let notificationMessage = notificationData["notification_message"] as? String else{print("notification data parsing error3");return}
                guard let readStatus = notificationData["read_status"] as? Int else{print("notification data parsing error4");return}
                guard let notificationTime = notificationData["notificationTime"] as? Int else{print("notification data parsing error5");return}
                if readStatus == 0{
                    read = false
                }else{
                    read = true
                }
                
                let notification = Notification(id: String(reciever), notificationImage: notificationImage, notificationMessage: notificationMessage, readStatus: read!, notificationTime: String(notificationTime))
               
                notifications.append(notification)
                //print(notifications.count)
                
                completion()

            }
            
            //let dataArray = allData[0]
            //guard let arr = dataArray as? [Any] else {print("allDatArrayaerr");return}
            
            
        } failure: { error in
            print(error)
        }
        
        
    }
    
    
    func fetchDataToNotificationCell(index:Int) -> Notification{
        
        return notifications[index]
    }
    
    
    func readNotification(token: String, notificationId: String, completion: @escaping(String) -> Void, fail: @escaping () -> Void){
        
        
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/notification?notificationId=\(notificationId)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        networkManeger.fetchData(request: request){ data in
            
            print(data)
            guard let status = data as? [String] else{return}
            completion(status[0])
            
            
            
        } failure: {error in
            print(error)
        }
        
    }
    
}
