//
//  AssignmentResponse.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation


class AssignmentResponse {
    
    
    var assignmentId : Int
    var assinmentStatus : Bool
    var assignmentName: String
    var testDuration : Int
    var questionCount: Int
    var grade : Int
    
    init(assignmentId : Int, assinmentStatus: Bool, assignmentName: String, testDuration : Int, questionCount: Int, grade : Int) {
        
        self.assignmentId = assignmentId
        self.assinmentStatus = assinmentStatus
        self.assignmentName = assignmentName
        self.testDuration = testDuration
        self.questionCount = questionCount
        self.grade = grade
        
    }
}
