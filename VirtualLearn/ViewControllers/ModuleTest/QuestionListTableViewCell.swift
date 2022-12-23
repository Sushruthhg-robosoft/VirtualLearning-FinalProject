//
//  QuestionListTableViewCell.swift
//  TestResultScreen
//
//  Created by Sushruth H G on 13/12/22.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var answerDisplay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func questionAnswerDisplay(data: String, answer: Bool) {
        questionNumber.text = "Question"+data
        if(answer) {
            answerDisplay.text = "Correct Answer"
            answerDisplay.textColor = UIColor(red: 30/255, green: 171/255, blue: 13/255, alpha: 1)
        }
        else {
            answerDisplay.text = "Wrong Answer"
            answerDisplay.textColor = UIColor(red: 234/255, green: 38/255, blue: 38/255, alpha: 1)
        }
    }
}
