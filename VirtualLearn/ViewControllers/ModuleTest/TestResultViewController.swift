//
//  ViewController.swift
//  TestResultScreen
//
//  Created by Sushruth H G on 13/12/22.
//

import UIKit

class TestResultViewController: UIViewController {

    @IBOutlet weak var middleLeftView: UIView!
    
    @IBOutlet weak var middleRightView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var gradeDisplay: UILabel!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var ChapterName: UILabel!
    @IBOutlet weak var passingGrade: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var wrongAnswers: UILabel!
    
    let testviewModel = ModuleTestViewModel()
    let mainShared = mainViewModel.mainShared
    var questionResults = [QuestionAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        testviewModel.getAnswer(token: mainShared.token, assignnmentId: "5") { questionAnswerDetails in
            print("sucess")
//            print(questionAnswerDetails)
            
            DispatchQueue.main.async {
                self.questionResults = questionAnswerDetails.questionAnswer
                self.courseName.text = questionAnswerDetails.courseName
                self.ChapterName.text = questionAnswerDetails.chapterName
                self.gradeDisplay.text = questionAnswerDetails.grade
                self.passingGrade.text = questionAnswerDetails.passingMarks + "/100"
                self.correctAnswer.text = questionAnswerDetails.correctAnswers + "/" + String(self.questionResults.count)
                self.wrongAnswers.text = questionAnswerDetails.wrongAnswers + "/" + String(self.questionResults.count)
                
               
                self.tableView.reloadData()
            }
        } fail: {
            print("error")
        }

        middleLeftView.layer.cornerRadius = 5
        middleRightView.layer.cornerRadius = 5
       
        middleView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        middleView.layer.shadowOpacity = 100
        middleView.layer.shadowRadius = 5
        middleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.delegate = self
        tableView.dataSource = self
    }


}


extension TestResultViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuestionListTableViewCell
        cell.questionAnswerDisplay(data: String(indexPath.row + 1) , answer: questionResults[indexPath.row].answerStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "showQuestionResultViewController") as! showQuestionResultViewController
        vc.datatoDisplay = questionResults[indexPath.row]
        vc.questionNumber = indexPath.row
        present(vc, animated: true, completion: nil)
    }
    
    
}


