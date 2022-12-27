//
//  ViewController.swift
//  CreatePasswordScreens
//
//  Created by Anushree J C on 07/12/22.
//

import UIKit
class CreateNewPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    @IBOutlet weak var newPasswordline: UIView!
    @IBOutlet weak var confirmPasswordLine: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var mobileNumber = ""
    var activeTextField : UITextField? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeHideKeyboard()
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        passwordView.isHidden = true
        passwordView.layer.cornerRadius = 10
        passwordView.layer.borderWidth = 1
        resetPasswordBtn.isEnabled = false
        resetPasswordBtn.backgroundColor = #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
        
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
    
    @IBAction func passwordChangedBegin(_ sender: Any) {
        newPasswordline.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
        passwordView.isHidden = true
    }
    
    
    @IBAction func confirmPasswordChangedBegin(_ sender: Any) {
        confirmPasswordLine.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        if newPasswordTextField.text == confirmPasswordTextField.text {
            resetPasswordBtn.isEnabled = true
            resetPasswordBtn.backgroundColor =  #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
            resetPasswordBtn.alpha = 1
        }
        else {
            resetPasswordBtn.isEnabled = false
            resetPasswordBtn.backgroundColor = #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
            resetPasswordBtn.alpha = 0.7
        }
        
        if let password = newPasswordTextField.text {
            if(password.count > 5)
            {
                if(passwordMatched(password)) {
                    passwordView.isHidden = true
                }
            }
            else {
                passwordView.isHidden = false
            }
        }
    }
    
    
    @IBAction func confirmPasswordEditChanged(_ sender: Any) {
        
        
        if newPasswordTextField.text == confirmPasswordTextField.text {
            resetPasswordBtn.isEnabled = true
            resetPasswordBtn.backgroundColor =  #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
            resetPasswordBtn.alpha = 1
        }
        else {
            resetPasswordBtn.isEnabled = false
            resetPasswordBtn.backgroundColor = #colorLiteral(red: 0.9553547502, green: 0.4519486427, blue: 0.372556448, alpha: 1)
            resetPasswordBtn.alpha = 0.7
        }
    }
    
    @IBAction func resetPasswordButtonClicked(_ sender: Any) {
        let viewmodel = LoginViewModel()
        viewmodel.resetPassword(mobileNumber: "+91"+mobileNumber, password: confirmPasswordTextField.text!){
            
        } fail: {
            
        }
    }
    
    func passwordMatched(_ value: String) -> Bool {
        let regular = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return predicate.evaluate(with: value)
        
    }


func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newPasswordTextField {
            textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmPasswordTextField {
               textField.resignFirstResponder()
        }
        return true
    }
}


extension CreateNewPasswordViewController {
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
