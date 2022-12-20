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
        let url = URL(string: "https://app-virtuallearning-221207091853.azurewebsites.net/user/questions?limit=3&page=1&assignmentId=5")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(mainshared.token)", forHTTPHeaderField: "Authorization")
        networkManager.fetchDataJson(request: request) { data in
//        print(data)
            guard let questionData = data as? [[String: Any]] else {return}
            for apiQuestionData in questionData {
//            guard let apiQuestionData = questionData as? [String: Any] else {return}
                guard let questionId = apiQuestionData["questionId"] as? Int else {print("questionViewModel error1");return}
                guard let questionName = apiQuestionData["questionName"] as? String else {print("questionViewModel error2");return}
                guard let option1 = apiQuestionData["option_1"] as? String else {print("questionViewModel error3");return}
                guard let option2 = apiQuestionData["option_2"] as? String else {print("questionViewModel error4");return}
                guard let option3 = apiQuestionData["option_3"] as? String else {print("questionViewModel error5");return}
                guard let option4 = apiQuestionData["option_4"] as? String else {print("questionViewModel error6");return}
           
                
            let questionData = ModuleTestData(questionId: String(questionId), questionName: questionName, option_1: option1, option_2: option2, option_3: option3, option_4: option4)
                self.moduleTestData.append(questionData)
            }
            success()

      
        } failure: { (error) in
            print(error)
            fail()
        }
    }
}


