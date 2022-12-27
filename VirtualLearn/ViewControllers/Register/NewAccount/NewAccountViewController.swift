//
//  NewAccountViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import UIKit

class NewAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enteredMobileNumber: UITextField!
    @IBOutlet weak var continueBtn: LoadingButton!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    let verificationOTP = VerificationOTP()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        
        enteredMobileNumber.delegate = self
        
        if(view.bounds.height > 500) {
            
            viewHeight.constant = view.bounds.height - 50
        }
        enteredMobileNumber.removeBorder()
        
    }
    
    
    
    @IBAction func continueButton(_ sender: Any) {
        
        guard let mobileNumber = enteredMobileNumber.text else {return}
        if mobileNumber.count != 10 {
            self.okAlertMessagePopup(message: "Phone number should be 10 digits")
            return
        }
        continueBtn.showLoading()
        verificationOTP.checkphoneNumberForNewUser(mobileNumber: "+91"+mobileNumber) {
            DispatchQueue.main.async {
                self.continueBtn.hideLoading()
                let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
                vc.mobileNumber = mobileNumber
                self.navigationController?.pushViewController(vc, animated: true)
                vc.mobileNumber = mobileNumber
                
                self.verificationOTP.getOTP(mobileNumber: "+917022011412")
            }
        } fail: {
            DispatchQueue.main.async {
                self.continueBtn.hideLoading()
                self.okAlertMessagePopup(message: "Your already registered, Please Login")
            }
        }
        
        
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "LoginPageViewController") as! LoginPageViewController
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    


func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == enteredMobileNumber {
            textField.resignFirstResponder()
            
        }
    return true
}
}

extension NewAccountViewController {
func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}


