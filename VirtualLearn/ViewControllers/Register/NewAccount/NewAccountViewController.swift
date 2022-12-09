//
//  NewAccountViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import UIKit

class NewAccountViewController: UIViewController {

    @IBOutlet weak var enteredMobileNumber: UITextField!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(view.bounds.height > 500) {
            
        viewHeight.constant = view.bounds.height - 50
            
        }
        enteredMobileNumber.removeBorder()
        
    }
    

    
    @IBAction func continueButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
   
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
}
