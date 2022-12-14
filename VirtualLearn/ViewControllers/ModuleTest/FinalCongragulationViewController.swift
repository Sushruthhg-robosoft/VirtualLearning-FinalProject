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
    var coursename = ""
    var courseId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        courseName.text = coursename
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewCerticateCliked(_ sender: Any) {
    
        let vc = storyboard?.instantiateViewController(identifier: "ViewCertificateViewController") as? ViewCertificateViewController
        if let viewController = vc{
            viewController.courseId = courseId
          navigationController?.pushViewController(viewController, animated: true)
    }
    
}
}
