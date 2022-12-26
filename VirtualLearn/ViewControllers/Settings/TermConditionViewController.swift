//
//  TermConditionViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 13/12/22.
//

import UIKit

class TermConditionViewController: UIViewController {
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var label = ""
    var content = ""
    
    
    override func viewDidLoad() {
        privacyPolicyLabel.text = label
        textView.text = content
        
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}


