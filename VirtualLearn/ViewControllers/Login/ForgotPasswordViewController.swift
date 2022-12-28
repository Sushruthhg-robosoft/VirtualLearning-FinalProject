//
//  ForgotPasswordViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enteredMobileNumber: borderlessTextField!
    @IBOutlet weak var virificationIcon: UIImageView!
    @IBOutlet weak var phoneNumberUnderLineView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeTextField : UITextField? = nil
    
    let viewmodel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()

        virificationIcon.isHidden = true
        phoneNumberUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        errorView.isHidden = true
      
        enteredMobileNumber.becomeFirstResponder()
        enteredMobileNumber.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
      }
        
      func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
      }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
           else {
             return
           }

           let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
           scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
          scrollView.contentInset = contentInsets
           scrollView.scrollIndicatorInsets = contentInsets
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
                    otpViewModel.getOTP(mobileNumber: mobileNumber)
                    let vc = self.storyboard?.instantiateViewController(identifier: "VerifyAccountViewController") as! VerifyAccountViewController
                    vc.isForgotPassword = true
                    vc.verificationText = "Verification"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } fail: {
                DispatchQueue.main.async {
                    self.okAlertMessagePopup(message: "Your Not A Registered User, Please Register")
                }
            }
            
        }
        
        
        
    }
    
    @IBAction func phoneNumberTextField(_ sender: Any) {
        
        if enteredMobileNumber.text?.count == 10{
            
            virificationIcon.isHidden = false
            phoneNumberUnderLineView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.6549019608, blue: 0.231372549, alpha: 1)
            virificationIcon.image = #imageLiteral(resourceName: "icn_textfield_right-1")
            
        }
        else{
            
            virificationIcon.isHidden = false
            phoneNumberUnderLineView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            virificationIcon.image = #imageLiteral(resourceName: "icn_textfield_wrong")
        }
    }
}


   
