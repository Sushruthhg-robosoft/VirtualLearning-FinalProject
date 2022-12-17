//
//  AssignmentResponse.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation


class AssignmentResponse {
    
    var assignmentId : Int
    var assignmentName: String
    var testDuration : String
    var questionCount: Int
    var grade : Float
    
    init(assignmentId : Int, assignmentName: String, testDuration : String, questionCount: Int, grade : Float) {
        
        self.assignmentId = assignmentId
        self.assignmentName = assignmentName
        self.testDuration = testDuration
        self.questionCount = questionCount
        self.grade = grade
        
    }
}
