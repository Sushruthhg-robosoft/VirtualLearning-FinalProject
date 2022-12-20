//
//  ModuleTestCollectionViewCell.swift
//  ModuleTestPagesScreen
//
//  Created by Anushree J C on 15/12/22.
//

import UIKit

protocol saveAnswers {
    func save(QuestionID: Int, Answer: String)
}

class ModuleTestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option1Label: UILabel!
    var QuestionInd: Int?
    @IBOutlet weak var option1Image: UIImageView!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option2Image: UIImageView!
    
    var delegate: saveAnswers?
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option3Image: UIImageView!
    
    @IBOutlet weak var option4Btn: UIButton!
    @IBOutlet weak var option4Label: UILabel!
    @IBOutlet weak var option4Image: UIImageView!
    
        @IBAction func onClickOption1(_ sender: Any) {
            option1Btn.selectBtn()
            option2Btn.deselectBtn()
            option3Btn.deselectBtn()
            option4Btn.deselectBtn()
    
            option1Label.selected()
            option2Label.deselected()
            option3Label.deselected()
            option4Label.deselected()
    
            option1Image.selected()
            option2Image.deselected()
            option3Image.deselected()
            option4Image.deselected()
            
            delegate?.save(QuestionID: QuestionInd!, Answer: option1Label.text!)
        }
    
        @IBAction func onClickOption2(_ sender: Any) {
    
            option1Btn.deselectBtn()
            option2Btn.selectBtn()
            option3Btn.deselectBtn()
            option4Btn.deselectBtn()
    
            option2Label.selected()
            option1Label.deselected()
            option3Label.deselected()
            option4Label.deselected()
    
            option2Image.selected()
            option1Image.deselected()
            option3Image.deselected()
            option4Image.deselected()
            delegate?.save(QuestionID: QuestionInd!, Answer: option2Label.text!)
        }
    
        @IBAction func onClickOption3(_ sender: Any) {
            option3Btn.selectBtn()
            option2Btn.deselectBtn()
            option1Btn.deselectBtn()
            option4Btn.deselectBtn()
    
            option3Label.selected()
            option2Label.deselected()
            option1Label.deselected()
            option4Label.deselected()
    
    
            option3Image.selected()
            option2Image.deselected()
            option1Image.deselected()
            option4Image.deselected()
            delegate?.save(QuestionID: QuestionInd!, Answer: option3Label.text!)
        }
    
        @IBAction func onClickOption4(_ sender: Any) {
            option4Btn.selectBtn()
            option2Btn.deselectBtn()
            option3Btn.deselectBtn()
            option1Btn.deselectBtn()
    
            option4Label.selected()
            option2Label.deselected()
            option3Label.deselected()
            option1Label.deselected()
    
            option4Image.selected()
            option2Image.deselected()
            option3Image.deselected()
            option1Image.deselected()
            delegate?.save(QuestionID: QuestionInd!, Answer: option4Label.text!)
        }
    
        
    
}
extension UIButton {
    func selectBtn() {
        self.backgroundColor = #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
    }

    func deselectBtn() {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

extension UILabel {
    func selected() {
        self.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }

    func deselected() {
        self.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

}

extension UIImageView {
    func selected() {
        self.image = #imageLiteral(resourceName: "Simle")
    }

    func deselected() {
        self.image = #imageLiteral(resourceName: "icn_option unchecked")
    }
}
