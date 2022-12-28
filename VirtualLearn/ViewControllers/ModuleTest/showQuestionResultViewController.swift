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
            changeView(label: option1Answer, image: option1Image, view: option1View)
        }
        
        else if(dataDisplay.correctAnswer == option2Answer.text) {
            changeView(label: option2Answer, image: option2Image, view: option2View)
        }
        
        else if(dataDisplay.correctAnswer == option3Answer.text) {
            changeView(label: option3Answer, image: option3Image, view: option3View)
        }
        
        else if(dataDisplay.correctAnswer == option4Answer.text) {
            changeView(label: option4Answer, image: option4Image, view: option4View)
        }
        
        if(dataDisplay.correctAnswer != dataDisplay.givenAnswer) {
            if(dataDisplay.givenAnswer == option1Answer.text) {
                changeWrongView(label: option1Answer, image: option1Image, view: option1View)
            }
            else if(dataDisplay.givenAnswer == option2Answer.text) {
                changeWrongView(label: option2Answer, image: option2Image, view: option2View)
            }
            else if(dataDisplay.givenAnswer == option3Answer.text) {
                changeWrongView(label: option3Answer, image: option3Image, view: option3View)
            }
            else if(dataDisplay.givenAnswer == option4Answer.text) {
                changeWrongView(label: option4Answer, image: option4Image, view: option4View)
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
    
    func changeView(label: UILabel, image: UIImageView, view: UIView) {
        label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.backgroundColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
        image.image = #imageLiteral(resourceName: "icn_option checked")
    }
    func changeWrongView(label: UILabel, image: UIImageView, view: UIView) {
        label.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        view.backgroundColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
        image.image = #imageLiteral(resourceName: "icn_option wrong")
    }
    
    @IBAction func onCancelTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
