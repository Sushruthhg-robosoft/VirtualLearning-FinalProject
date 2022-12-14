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
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCancelTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
