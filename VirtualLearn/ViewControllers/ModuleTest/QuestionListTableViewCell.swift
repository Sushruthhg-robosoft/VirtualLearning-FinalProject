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

}
