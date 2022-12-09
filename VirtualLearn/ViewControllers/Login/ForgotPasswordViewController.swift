//
//  ForgotPasswordViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }
    


    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
        
        vc.isForgotPassword = true
        
        vc.verificationText = "Verification"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
