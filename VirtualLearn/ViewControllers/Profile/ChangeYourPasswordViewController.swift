//
//  ChangeYourPasswordViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 10/12/22.
//

import UIKit

class ChangeYourPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    @IBOutlet weak var resetPassword: UIButton!
    @IBOutlet weak var invalidPasswordView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordIconImage: UIImageView!
    @IBOutlet weak var currentPasswordLine: UIView!
    @IBOutlet weak var newpasswordUnderLine: UIView!
    @IBOutlet weak var confirmPasswordUnderLine: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeTextField : UITextField? = nil
    let profileViewModel = ProfileViewModel()
    let shared  = mainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        currentPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        confirmNewPasswordTextField.delegate = self
        
        navigationController?.navigationBar.isHidden = true
        currentPasswordTextField.removeBorder()
        newPasswordTextField.removeBorder()
        confirmNewPasswordTextField.removeBorder()
        passwordView.isHidden = true
        invalidPasswordView.isHidden = true
        
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
    
    @IBAction func newPasswordEditingBegin(_ sender: Any) {
        passwordView.isHidden = false
    }
    
    @IBAction func newPasswordEditingChanged(_ sender: Any) {
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
    
    func passwordMatched(_ value: String) -> Bool {
        let regular = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return predicate.evaluate(with: value)
        
    }
    
    
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickResetButton(_ sender: Any) {
        guard let currentpassword = currentPasswordTextField.text else {return}
        guard let newpassword = newPasswordTextField.text else {return}
        let loader = self.loader()
        profileViewModel.changePasswordForExistingUser(token: shared.token, password: newpassword, oldpassword: currentpassword) {
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        fail: { error in
            self.stopLoader(loader: loader)
            print("failures")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    self.okAlertMessagePopup(message: "something went wrong password not changed")
                }
            }
            
        }
    }
  


func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentPasswordTextField {
            textField.resignFirstResponder()
            newPasswordTextField.becomeFirstResponder()
        }
        else if textField == newPasswordTextField {
               textField.resignFirstResponder()
            confirmNewPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmNewPasswordTextField {
               textField.resignFirstResponder()
        }
        return true
    }
}


//extension ChangeYourPasswordViewController {
//    func initializeHideKeyboard(){
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(dismissMyKeyboard))
//    
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissMyKeyboard(){
//        
//        view.endEditing(true)
//    }
//}
//    
    

    


