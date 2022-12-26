//
//  FinalCongragulationViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 23/12/22.
//

import UIKit

class FinalCongragulationViewController: UIViewController {

    @IBOutlet weak var imagetoDisplay: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var aprrovedRateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        grade.isHidden = true
        aprrovedRateLabel.isHidden = true
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func viewCerticateCliked(_ sender: Any) {
        
    }
    
}
