//
//  ViewController.swift
//  ModuleTestScreens
//
//  Created by Anushree J C on 12/12/22.
//

import UIKit

class ModuleTestViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var noOfQuestions: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var chapterNo: UILabel!
    @IBOutlet weak var previousPage: UIButton!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option4Label: UILabel!
    
    
    @IBOutlet weak var option1Image: UIImageView!
    @IBOutlet weak var option2Image: UIImageView!
    @IBOutlet weak var option3Image: UIImageView!
    @IBOutlet weak var option4Image: UIImageView!
    var time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerCountdown()
    }
    @IBAction func onClickOption1(_ sender: Any) {
        option1.selectBtn()
        option2.deselectBtn()
        option3.deselectBtn()
        option4.deselectBtn()
        
        option1Label.selected()
        option2Label.deselected()
        option3Label.deselected()
        option4Label.deselected()
        
        option1Image.selected()
        option2Image.deselected()
        option3Image.deselected()
        option4Image.deselected()
    }

    @IBAction func onClickOption2(_ sender: Any) {

        option1.deselectBtn()
        option2.selectBtn()
        option3.deselectBtn()
        option4.deselectBtn()
        
        option2Label.selected()
        option1Label.deselected()
        option3Label.deselected()
        option4Label.deselected()
        
        option2Image.selected()
        option1Image.deselected()
        option3Image.deselected()
        option4Image.deselected()
    }
    
    @IBAction func onClickOption3(_ sender: Any) {
        option3.selectBtn()
        option2.deselectBtn()
        option1.deselectBtn()
        option4.deselectBtn()
        
        option3Label.selected()
        option2Label.deselected()
        option1Label.deselected()
        option4Label.deselected()
        
        
        option3Image.selected()
        option2Image.deselected()
        option1Image.deselected()
        option4Image.deselected()
    }
    
    @IBAction func onClickOption4(_ sender: Any) {
        option4.selectBtn()
        option2.deselectBtn()
        option3.deselectBtn()
        option1.deselectBtn()
        
        option4Label.selected()
        option2Label.deselected()
        option3Label.deselected()
        option1Label.deselected()
        
        option4Image.selected()
        option2Image.deselected()
        option3Image.deselected()
        option1Image.deselected()
    }
    
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        showAlertforCancel(title: "Alert", message: "Are you sure you want to quit the exam?") { action in
            self.dismiss(animated: true, completion: nil)
            
        } handlerCancel: { actionCancel in
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    @IBAction func onClickSubmit(_ sender: Any) {
        
        showAlertforSubmit(title: "Do you want to end the test?", message: "You still have \(time) remaining.      If you want to check your answer again, press cancel button. If you want to end the test and submit your answers you can press submit button."){ action in
            self.dismiss(animated: true, completion: nil)
                } handlerCancel: { actionCancel in
                    self.dismiss(animated: true, completion: nil)}
        
    }

    func timerCountdown(){
            var remainingTime = 60 * 10
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                remainingTime -= 1

                if remainingTime <= 0 {
                    timer.invalidate()
                }
                
                let minutes = remainingTime / 60
                let seconds = remainingTime % 60
                self.time = String(format: "%02d:%02d", minutes, seconds)
                self.timeLabel.text = self.time
        
            }
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
