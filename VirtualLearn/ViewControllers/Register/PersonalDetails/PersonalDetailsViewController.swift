//
//  PersonalDetailsViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import UIKit

class PersonalDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordIButton: UIButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var detailsScreen: UIView!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var RegistrayionButtonOutlet: UIButton!
    @IBOutlet weak var successScreen: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var storagemaner = StorageManeger.shared
    let personalData = PersonalData()
    let mainshared = mainViewModel.mainShared
    var enterdMobileNumber = ""
    var usernameStatus = false
    var activeTextField : UITextField? = nil
    var emailId = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        fullNameTextField.delegate = self
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        RegistrayionButtonOutlet.isEnabled = false
        successScreen.isHidden = true
        detailsScreen.isHidden = false
        view.bringSubviewToFront(detailsScreen)
        mobileNumber.text = "+91"+enterdMobileNumber
        
        fullNameTextField.removeBorder()
        userNameTextField.removeBorder()
        emailTextField.removeBorder()
        passwordTextField.removeBorder()
        confirmPasswordTextField.removeBorder()
        
        
        fullNameTextField.lineheight()
        userNameTextField.lineheight()
        emailTextField.lineheight()
        passwordTextField.lineheight()
        confirmPasswordTextField.lineheight()
        
        passwordView.isHidden = true
        RegistrayionButtonOutlet.isEnabled = false
        RegistrayionButtonOutlet.alpha = 0.5
        passwordIButton.layer.cornerRadius = self.passwordIButton.frame.height/2
        fullNameLabel.isHidden = true
        userNameLabel.isHidden = true
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        confirmPasswordLabel.isHidden = true
        
        
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
 

       
    
  
    
    @IBAction func fullNameTextBeginning(_ sender: Any) {
        fullNameLabel.isHidden = false
        fullNameTextField.placeholder = ""
    }
    
    @IBAction func userNameTextBeginning(_ sender: Any) {
        userNameLabel.isHidden = false
        userNameTextField.placeholder = ""
    }
    
    @IBAction func emailtextBeginning(_ sender: Any) {
        emailLabel.isHidden = false
        emailTextField.placeholder = ""
    }
    
    @IBAction func passwordIButtonCliked(_ sender: Any) {
        
        passwordView.isHidden = !(passwordView.isHidden)
    }
    
    @IBAction func confirmTextBeginning(_ sender: Any) {
        confirmPasswordLabel.isHidden = false
        confirmPasswordTextField.placeholder = ""
    }
    
    
    @IBAction func passwordTextBeginning(_ sender: Any) {
        passwordTextField.placeholder = ""
        passwordLabel.isHidden = false
        passwordIButton.isHidden = true
        passwordView.isHidden = false
    }
    @IBAction func firstNameChanged(_ sender: Any) {
        guard fullNameTextField != nil else {
            return
        }
        checAllField()
    }
    
    @IBAction func userNameChanged(_ sender: Any) {
        
        guard let userName = userNameTextField.text else {
            return
        }
        if (userName.count > 4) {
            personalData.validatingUserName(userName: userName) { sucess in
                DispatchQueue.main.async {
                    self.usernameStatus = true
                    self.checAllField()
                }
            } fail: { fail in
                self.usernameStatus = false
                DispatchQueue.main.async {
                    self.alertPopup(message: "Username Already exist.")
                }
                
            }
        }
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        guard emailTextField != nil else {
            return
        }
        checAllField()
    }
    
    @IBAction func confirmPasswordChanged(_ sender: Any) {
        guard confirmPasswordTextField != nil else {
            return
        }
        checAllField()
    }
    
    @IBAction func passwordTextEditing(_ sender: Any) {
        if let password = passwordTextField.text {
            if(password.count > 5)
            {
                if(passwordMatched(password)) {
                    
                    passwordView.isHidden = true
                }
                else {
                    passwordView.isHidden = false
                }
            }
            else
            {
                passwordView.isHidden = false
            }
        }
        checAllField()
    }
    
    @IBAction func RegistrationButtonClick(_ sender: Any) {
        
        let loader = self.loader()
        let currentUser =  personalData.assignCurrentRegisterValue(fullName: fullNameTextField.text!, userName: userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, mobileNumber: mobileNumber.text!)
        personalData.registeringUser(user: currentUser) { sucess in
            DispatchQueue.main.async {
                
                self.stopLoader(loader: loader)
                self.detailsScreen.isHidden = true
                self.successScreen.isHidden = false
                self.view.bringSubviewToFront(self.successScreen)
            }
        } fail: { fail in
            print(fail)
        }
        
        
    }
    
    // endTextField
    
    @IBAction func fullnameTextEnd(_ sender: Any) {
        
        guard fullNameTextField.text != "" else {
            fullNameLabel.isHidden = true
            fullNameTextField.placeholder = "Full name"
            return
        }
        fullNameLabel.isHidden = false
    }
    
    @IBAction func userNameTextEnd(_ sender: Any) {
        guard userNameTextField.text != "" else {
            userNameLabel.isHidden = true
            userNameTextField.placeholder = "User name"
            return
        }
        userNameLabel.isHidden = false
    }
    
    @IBAction func emailTextEnd(_ sender: Any) {
        guard emailTextField.text != "" else {
            emailLabel.isHidden = true
            emailTextField.placeholder = "Email"
            return
        }
        emailId = !isValidEmail(email: emailTextField.text!)
        if emailId {
            okAlertMessagePopup(message: "Enter Valid Email")
            RegistrayionButtonOutlet.isEnabled = false
            
        }
        emailLabel.isHidden = false
    }
    
    @IBAction func passwordTextEnd(_ sender: Any) {
        guard passwordTextField.text != "" else {
            passwordLabel.isHidden = true
            passwordTextField.placeholder = "password"
            passwordIButton.isHidden = false
            passwordView.isHidden = true
            return
        }
        passwordLabel.isHidden = false
    }
    
    @IBAction func confirmpasswordTextEnd(_ sender: Any) {
        guard confirmPasswordTextField.text != "" else {
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.placeholder = "Confirm Password"
            return
        }
        confirmPasswordLabel.isHidden = false
        
    }
    
    func passwordMatched(_ value: String) -> Bool{
        
        let regular = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        
        return predicate.evaluate(with: value)
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    func checAllField() {
        
        if( fullNameTextField.text != "" && usernameStatus == true && emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" && passwordTextField.text! == confirmPasswordTextField.text!)
        {
            RegistrayionButtonOutlet.isEnabled = true
            RegistrayionButtonOutlet.alpha = 1
        }
        else
        {
            RegistrayionButtonOutlet.isEnabled = false
            RegistrayionButtonOutlet.alpha = 0.5
        }
    }
    
    @IBAction func onClickLetsGetStarted(_ sender: Any) {
        let loader = self.loader()
        mainshared.loginViewModel.loginUser(userName: userNameTextField.text!, password: passwordTextField.text!) { (data) in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.storagemaner.setLoggedIn()
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                vc.mainShared.token = data
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } fail: {
            print("Login user fail")
        }
        
        
        
    }

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            textField.resignFirstResponder()
            userNameTextField.becomeFirstResponder()
        }
        else if textField == userNameTextField {
               textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField {
               textField.resignFirstResponder()
              passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
               textField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if textField == confirmPasswordTextField {
               textField.resignFirstResponder()
            
        }

        return true
    }
}

extension PersonalDetailsViewController{
    
    func alertPopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
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
