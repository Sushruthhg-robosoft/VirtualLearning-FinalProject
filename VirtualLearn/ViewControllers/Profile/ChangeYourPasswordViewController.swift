//
//  ChangeYourPasswordViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 10/12/22.
//

import UIKit

class ChangeYourPasswordViewController: UIViewController {
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
    
    let profileViewModel = ProfileViewModel()
    let shared  = mainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        currentPasswordTextField.removeBorder()
        newPasswordTextField.removeBorder()
        confirmNewPasswordTextField.removeBorder()
        passwordView.isHidden = true
        invalidPasswordView.isHidden = true
        
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
    
}







