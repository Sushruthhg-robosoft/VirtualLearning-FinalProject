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
    
    @IBOutlet weak var RegistrayionButtonOutlet: UIButton!
    
    @IBOutlet weak var successScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        successScreen.isHidden = true
        
        
        
        
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
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(vc, animated: true)
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
    
    @IBAction func onClickLetsGetStarted(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
