//
//  ForgotPasswordViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var enteredMobileNumber: borderlessTextField!
    
    let viewmodel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSend(_ sender: Any) {
        
        guard let mobileNumber = enteredMobileNumber.text else {return}
        
        if(mobileNumber.count == 10)
        {
            viewmodel.checkphoneNumberForExsistingUser(mobileNumber: "+91"+mobileNumber) {
                DispatchQueue.main.async {
                    let otpViewModel = VerificationOTP()
                    otpViewModel.getOTP(mobileNumber: "+917022011412")
                    let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
                    vc.isForgotPassword = true
                    vc.verificationText = "Verification"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } fail: {
                //alert message
                DispatchQueue.main.async {
                    self.okAlertMessagePopup(message: "Your Not A Registered User, Please Register")
                }
            }

        }
//        viewmodel.resetPassword(mobileNumber: "+917022011412", password: "Hellllo1234"){
//
//        } fail: {
//
//        }
       
        
    }
}
