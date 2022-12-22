//
//  ModuleTestData.swift
//  ModuleTestPagesScreen
//
//  Created by Anushree J C on 17/12/22.
//

import Foundation

class ModuleTestData{
    var questionId: String
    var questionName: String
    var option_1: String
    var option_2: String
    var option_3: String
    var option_4: String
    
    init(questionId: String, questionName: String, option_1: String, option_2: String, option_3: String, option_4: String) {
        self.questionId = questionId
        self.questionName = questionName
        self.option_1 = option_1
        self.option_2 = option_2
        self.option_3 = option_3
        self.option_4 = option_4
        
    }
}

struct QuestionModel {
    var id: Int
    var answer: String

    var dictionary: [String: Any] { return ["questionId": id, "givenAnswer": answer] }
}
