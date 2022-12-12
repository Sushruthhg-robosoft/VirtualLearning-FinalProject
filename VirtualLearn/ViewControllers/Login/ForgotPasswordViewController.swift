//
//  ForgotPasswordViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {


    let viewmodel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        
        viewmodel.resetPassword(mobileNumber: "+917022011412", password: "Hellllo1234"){
            
        } fail: {
            
        }
        let vc = storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
        
        vc.isForgotPassword = true
        
        vc.verificationText = "Verification"
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
