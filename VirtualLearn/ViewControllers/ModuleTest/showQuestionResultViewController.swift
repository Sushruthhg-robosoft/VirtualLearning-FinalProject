//
//  showQuestionResultViewController.swift
//  TestResultScreen
//
//  Created by Sushruth H G on 14/12/22.
//

import UIKit

class showQuestionResultViewController: UIViewController {
    
    @IBOutlet weak var option1Answer: UILabel!
    @IBOutlet weak var option1Image: UIImageView!
    @IBOutlet weak var option1View: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionNoLabel: UILabel!
    
    @IBOutlet weak var option2View: UIView!
    @IBOutlet weak var option2Image: UIImageView!
    @IBOutlet weak var option2Answer: UILabel!
    @IBOutlet weak var option3View: UIView!
    @IBOutlet weak var option3Image: UIImageView!
    @IBOutlet weak var option3Answer: UILabel!
    @IBOutlet weak var option4View: UIView!
    @IBOutlet weak var option4Image: UIImageView!
    @IBOutlet weak var option4Answer: UILabel!
    @IBOutlet weak var answerStatus: UILabel!
    
    var datatoDisplay: QuestionAnswer?
    var questionNumber = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerDisplay(datatoDisplay: datatoDisplay, questionNumber: questionNumber)
    }
    
    func answerDisplay(datatoDisplay: QuestionAnswer?, questionNumber: Int) {
        guard let dataDisplay = datatoDisplay else {return}
        questionNoLabel.text = "Question\(questionNumber+1)"
        question.text = dataDisplay.questionName
        option1Answer.text = dataDisplay.option1
        option2Answer.text = dataDisplay.option2
        option3Answer.text = dataDisplay.option3
        option4Answer.text = dataDisplay.option4
        
        if(dataDisplay.correctAnswer == option1Answer.text) {
            option1Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            option1View.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
            option1Image.image = #imageLiteral(resourceName: "icn_option checked")
        }
        else if(dataDisplay.correctAnswer == option2Answer.text) {
            option2Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            option2View.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
            option2Image.image = #imageLiteral(resourceName: "icn_option checked")
        }
        else if(dataDisplay.correctAnswer == option3Answer.text) {
            option3Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            option3View.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
            option3Image.image = #imageLiteral(resourceName: "icn_option checked")
        }
        else if(dataDisplay.correctAnswer == option4Answer.text) {
            option4Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            option4View.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
            option4Image.image = #imageLiteral(resourceName: "icn_option checked")
        }
        if(dataDisplay.correctAnswer != dataDisplay.givenAnswer) {
            if(dataDisplay.givenAnswer == option1Answer.text) {
                option1Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
                option1View.backgroundColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
                option1Image.image = #imageLiteral(resourceName: "icn_option wrong-1")
            }
            else if(dataDisplay.givenAnswer == option2Answer.text) {
                option2Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
                option2View.backgroundColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
                option2Image.image = #imageLiteral(resourceName: "icn_option wrong")
            }
            else if(dataDisplay.givenAnswer == option3Answer.text) {
                option3Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
                option3View.backgroundColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
                option3Image.image = #imageLiteral(resourceName: "icn_option wrong")
            }
            else if(dataDisplay.givenAnswer == option4Answer.text) {
                option4Answer.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
                option4View.backgroundColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
                option4Image.image = #imageLiteral(resourceName: "icn_option wrong")
            }
        }
        
        if(dataDisplay.answerStatus) {
            answerStatus.text = "Correct Answer"
            answerStatus.textColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
        }
        else {
            answerStatus.text = "Wrong Answer"
            answerStatus.textColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
        }
    }
    
    
    @IBAction func onCancelTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
