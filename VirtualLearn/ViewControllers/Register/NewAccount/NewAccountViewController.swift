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
    let verificationOTP = VerificationOTP()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(view.bounds.height > 500) {
            
        viewHeight.constant = view.bounds.height - 50
            
        }
        enteredMobileNumber.removeBorder()
        
    }
    

    
    @IBAction func continueButton(_ sender: Any) {
        guard let mobileNumber = enteredMobileNumber.text else {return}
//        print(mobileNumber)
        if mobileNumber.count != 10 {
            
            return
        }
        verificationOTP.checkphoneNumberForNewUser(mobileNumber: "+91"+mobileNumber) {
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
                vc.mobileNumber = mobileNumber
                self.navigationController?.pushViewController(vc, animated: true)
                vc.mobileNumber = mobileNumber
                
                self.verificationOTP.getOTP(mobileNumber: "+917022011412")
            }
        } fail: {
            DispatchQueue.main.async {
                self.okAlertMessagePopup(message: "Your already registered, Please Login")
            }
        }

        
        
    }
   
    @IBAction func loginButton(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "LoginPageViewController") as! LoginPageViewController
     
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
