//
//  LoginPageViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var invalidPopup: UIView!
    @IBOutlet weak var invalidMessage: UILabel!
    @IBOutlet weak var userNameUnderLineView: UIView!
    @IBOutlet weak var passwordUnderLineView: UIView!
    @IBOutlet weak var verifiedImg: UIImageView!
    
    let loginviewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        invalidPopup.isHidden = true
        userNameTextField.becomeFirstResponder()

    }
    
    @IBAction func userNameTextChangeOutlet(_ sender: Any) {
        invalidPopup.isHidden = true
        checkAllFileds()
    }
   
    
    @IBAction func passwordTextChangeOutlet(_ sender: Any) {
        checkAllFileds()
    }
    
   
    
    @IBAction func loginClick(_ sender: Any) {
        let loader = self.loader()
        loginviewModel.loginUser(userName: userNameTextField.text!, password: passwordTextfield.text!) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } fail: {
            self.stopLoader(loader: loader)
            DispatchQueue.main.async {
                self.invalidPopup.isHidden=false
                self.userNameTextField.text = ""
                self.passwordTextfield.text = ""
                self.invalidMessage.text = "Invalid credentials, please try again"
            }
            
            //print("login fails")
        }
        
        
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkAllFileds() {
        
        guard userNameTextField != nil else { return }
        guard passwordTextfield != nil else {return}
        
        loginButton.isEnabled = true
        loginButton.alpha = 1
    }
    
}
