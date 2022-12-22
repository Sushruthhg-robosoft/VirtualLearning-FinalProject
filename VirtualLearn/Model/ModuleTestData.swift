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

class QuestionAnswerDetails {
    var courseName: String
    var chapterName: String
    var grade: String
    var passingMarks: String
    var numberOfquestions: String
    var correctAnswers: String
    var wrongAnswers: String
    var questionAnswer: [QuestionAnswer]
    
    init(courseName: String, chapterName: String, grade: String, passingMarks: String, numberOfquestions: String, correctAnswers: String, wrongAnswers: String, questionAnswer: [QuestionAnswer]) {
        self.courseName = courseName
        self.chapterName = chapterName
        self.grade = grade
        self.passingMarks = passingMarks
        self.numberOfquestions = numberOfquestions
        self.correctAnswers = correctAnswers
        self.wrongAnswers = wrongAnswers
        self.questionAnswer = questionAnswer
}
}

class QuestionAnswer {
    var questionId: String
    var questionName: String
    var option1: String
    var option2: String
    var option3: String
    var option4: String
    var correctAnswer: String
    var givenAnswer: String
    var answerStatus: Bool
    
    
    init(questionId: String, questionName: String, option1: String, option2: String, option3: String, option4: String, correctAnswer: String,givenAnswer: String,answerStatus: Bool ) {
        self.questionId = questionId
        self.questionName = questionName
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correctAnswer = correctAnswer
        self.givenAnswer = givenAnswer
        self.answerStatus = answerStatus
   }
}

struct QuestionModel {
    var id: Int
    var answer: String

    var dictionary: [String: Any] { return ["questionId": id, "givenAnswer": answer] }
}
