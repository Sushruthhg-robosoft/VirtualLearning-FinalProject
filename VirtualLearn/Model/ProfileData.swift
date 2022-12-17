//
//  ProfileData.swift
//  VirtualLearn
//
//  Created by Anushree J C on 15/12/22.
//

import Foundation

class ProfileData {
    var userId: Int
    var profilePic: String?
    var fullName: String
    var userName: String
    var emailId: String
    var phoneNumber: String
    var occupation: String?
    var dateOfBirth: String?
    var numberOfCoursesCompleted: Int
    var numberOfChaptersCompleted: Int
    var numberOfTestsAttempted: Int
    var facebookLink: String?
    var twitterLink: String?
    
    init(userId: Int, profilePic: String?, fullName: String, userName: String, emailId: String, phoneNumber: String, occupation: String?, dateOfBirth: String?, numberOfCoursesCompleted: Int, numberOfChaptersCompleted: Int, numberOfTestsAttempted: Int, facebookLink: String?, twitterLink: String?) {
        self.userId = userId
        self.profilePic = profilePic
        self.fullName = fullName
        self.userName = userName
        self.emailId = emailId
        self.phoneNumber = phoneNumber
        self.occupation = occupation
        self.dateOfBirth = dateOfBirth
        self.numberOfChaptersCompleted = numberOfChaptersCompleted
        self.numberOfCoursesCompleted = numberOfCoursesCompleted
        self.numberOfTestsAttempted = numberOfTestsAttempted
        self.facebookLink = facebookLink
        self.twitterLink = twitterLink
        
    }
    
}
