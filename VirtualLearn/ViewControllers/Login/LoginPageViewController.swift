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
    
    let loginviewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5

    }
    
    @IBAction func userNameTextChangeOutlet(_ sender: Any) {
        checkAllFileds()
    }
   
    
    @IBAction func passwordTextChangeOutlet(_ sender: Any) {
        checkAllFileds()
    }
    
   
    
    @IBAction func loginClick(_ sender: Any) {
        loginviewModel.loginUser(userName: userNameTextField.text!, password: passwordTextfield.text!) {
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } fail: {
            print("login fails")
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
