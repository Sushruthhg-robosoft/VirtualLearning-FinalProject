//
//  PersonalDetailsViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import UIKit

class PersonalDetailsViewController: UIViewController {

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
    
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var RegistrayionButtonOutlet: UIButton!
    
    @IBOutlet weak var successScreen: UIView!
    let personalData = PersonalData()
    var enterdMobileNumber = ""
    var usernameStatus = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegistrayionButtonOutlet.isEnabled = false
        successScreen.isHidden = true
        mobileNumber.text = enterdMobileNumber
        
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
    }
    
    
    // begin textfield
    
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
            //alertMessage
            print("change userName")
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
    }
    
    @IBAction func RegistrationButtonClick(_ sender: Any) {
        
        let loader = self.loader()
        let currentUser =  personalData.assignCurrentRegisterValue(fullName: fullNameTextField.text!, userName: userNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
         personalData.registeringUser(user: currentUser) { sucess in
             print("sucessfull")
            DispatchQueue.main.async {
                
                self.stopLoader(loader: loader)
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
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
        userNameLabel.isHidden = false
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
        
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(vc, animated: true)
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
}
