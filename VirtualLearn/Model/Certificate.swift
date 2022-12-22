//
//  Certificate.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation


class Certificate {
    var joinedData: String
    var completedDate: String
    var completionDuration: String
    var grade: Int
    var certificateLink: String
    
    init(joinedData: String, completedDate: String, completionDuration: String, grade: Int, certificateLink: String) {
        self.joinedData = joinedData
        self.completedDate = completedDate
        self.completionDuration  = completionDuration
        self.grade = grade
        self.certificateLink = certificateLink
    }
}
