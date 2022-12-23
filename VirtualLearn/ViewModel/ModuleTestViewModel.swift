//
//  ModuleTestViewModel.swift
//  ModuleTestPagesScreen
//
//  Created by Anushree J C on 17/12/22.
//

import Foundation
class ModuleTestViewModel {
    let networkManager = NetWorkManager()
    var moduleTestData = [ModuleTestData]()
    var mainshared = mainViewModel.mainShared
   
    func getQuestions(limit: String, page: String, assignnmentId: String ,success: @escaping() -> Void, fail: @escaping () -> Void) {
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/questions?limit=3&page=1&assignmentId=5") else{return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(mainshared.token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
//        print(data)
            guard let questionData = data as? [[String: Any]] else {return fail()}
            for apiQuestionData in questionData {
//            guard let apiQuestionData = questionData as? [String: Any] else {return}
                guard let questionId = apiQuestionData["questionId"] as? Int else {print("questionViewModel error1");return fail()}
                guard let questionName = apiQuestionData["questionName"] as? String else {print("questionViewModel error2");return fail()}
                guard let option1 = apiQuestionData["option_1"] as? String else {print("questionViewModel error3");return fail()}
                guard let option2 = apiQuestionData["option_2"] as? String else {print("questionViewModel error4");return fail()}
                guard let option3 = apiQuestionData["option_3"] as? String else {print("questionViewModel error5");return fail()}
                guard let option4 = apiQuestionData["option_4"] as? String else {print("questionViewModel error6");return fail()}
           
                
            let questionData = ModuleTestData(questionId: String(questionId), questionName: questionName, option_1: option1, option_2: option2, option_3: option3, option_4: option4)
                self.moduleTestData.append(questionData)
            }
            success()

      
        } failure: { (error) in
            print(error)
            fail()
        }
    }
    
    func submitAnswer(token: String, assignnmentId: String, testAnswers: [Int: String], completion: @escaping() -> Void, fail: @escaping() -> Void) {
        
        guard let id = Int(assignnmentId) else {return fail()}
        
        var totalAnswer = [[String:Any]]()
        for answer in testAnswers {
            let new = QuestionModel(id: answer.key, answer: answer.value)
            totalAnswer.append(new.dictionary)
        }
        let parameter: [String: Any] = [

               "assignmentId": id,
               "questionAnswers": totalAnswer

           ]
        let network = NetWorkManager()
        print(parameter)
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/assignment")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: .fragmentsAllowed)
        
        network.fetchData(request: request) { result in
            print("result",result)
        } failure: { error in
            print("error",error)
        }

    }
    
    func getAnswer(token: String, assignnmentId: String, completion: @escaping(QuestionAnswerDetails) -> Void, fail: @escaping() -> Void) {
        var questionAnswer = [QuestionAnswer]()
        guard let id = Int(assignnmentId) else {return fail()}
        let network = NetWorkManager()
        guard let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/assignmentResult?assignmentId=\(id)") else {return fail()}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        network.requestData(request: request) { result in
            print("result",result)
            guard let apiData = result as? [String: Any] else {return fail()}
            guard let courseName = apiData["courseName"] as? String else {print("err1");return fail()}
            guard let chapterName = apiData["chapterName"] as? String else {print("err2");return fail()}
            guard let grade = apiData["grade"] as? Int else {print("err3");return fail()}
            guard let passingMarks = apiData["passing_marks"] as? Int else {print("err4");return fail()}
            guard let numberOfQuestions = apiData["numberOfQuestions"] as? Int else {print("err5");return fail()}
            guard let correctAnswers = apiData["correctAnswers"] as? Int else {print("err6");return fail()}
            guard let wrongAnswers = apiData["wrongAnswers"] as? Int else {print("err7");return fail()}
            
            guard let questionResults = apiData["questionResults"] as? [[String:Any]] else {print("err8"); return fail()}
            
            questionAnswer.removeAll()
            for eachQuestion in questionResults {
//                guard let questionDetails = eachQuestion as? [String:Any] else {print("err9"); return}
                
                guard let givenAnswer = eachQuestion["givenAnswer"] as? String else {print("err10"); return fail()}
                guard let correct = eachQuestion["correct"] as? Bool else {print("err11"); return fail()}
                
                guard let dataOfQuestion = eachQuestion["assignmentQuestion"]  as? [String:Any] else {print("err12"); return fail()}
                
                guard let questionId = dataOfQuestion["questionId"] as? Int else {print("err13"); return fail()}
                guard let questionName = dataOfQuestion["questionName"] as? String else {print("err14"); return fail()}
//                guard let assignmentId = dataOfQuestion["assignmentId"] as? Int else {print("err11"); return}
                guard let option_1 = dataOfQuestion["option_1"] as? String else {print("err15"); return fail()}
                guard let option_2 = dataOfQuestion["option_2"] as? String else {print("err16"); return fail()}
                guard let option_3 = dataOfQuestion["option_3"] as? String else {print("err17"); return fail()}
                guard let option_4 = dataOfQuestion["option_4"] as? String else {print("err18"); return fail()}
                guard let correctAnswer = dataOfQuestion["correctAnswer"] as? String else {print("err19"); return fail()}
                
              let question = QuestionAnswer(questionId: String(questionId), questionName: questionName, option1: option_1, option2: option_2, option3: option_3, option4: option_4, correctAnswer: correctAnswer, givenAnswer: givenAnswer, answerStatus: correct)
                questionAnswer.append(question)
                
            }
            
            let questionAnswerDetails = QuestionAnswerDetails(courseName: courseName, chapterName: chapterName, grade: String(grade), passingMarks: String(passingMarks), numberOfquestions: String(numberOfQuestions), correctAnswers: String(correctAnswers), wrongAnswers: String(wrongAnswers), questionAnswer: questionAnswer)
            
            completion(questionAnswerDetails)
            
        } failure: { error in
            print("error",error)
        }

    }
    
    
}

//struct QuestionModel {
//    var id: Int
//    var answer: String
//
//    var dictionary: [String: Any] { return ["questionId": id, "givenAnswer": answer] }
//}






