//
//  Notification.swift
//  VirtualLearn
//
//  Created by Manish R T on 13/12/22.
//

import Foundation
class Notification{
    
    var id: String
    var notificationImage: String
    var notificationMessage: String
    var readStatus: Bool
    var notificationTime: String
    
    init(id: String, notificationImage: String, notificationMessage: String, readStatus: Bool, notificationTime: String) {
        
        self.id = id
        self.notificationImage = notificationImage
        self.notificationMessage = notificationMessage
        self.readStatus = readStatus
        self.notificationTime = notificationTime
    }
}
