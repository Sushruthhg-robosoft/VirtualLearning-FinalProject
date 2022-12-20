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
    let shared = mainViewModel.mainShared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        invalidPopup.isHidden = true
        userNameTextField.becomeFirstResponder()
        verifiedImg.isHidden = true
        userNameUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        passwordUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        
        loginviewModel.checkUserNameForExsistingUser(userName: "santhosh") {
            
        } fail: {
            
        }


    }
    
    @IBAction func userNameTextChangeOutlet(_ sender: Any) {
        invalidPopup.isHidden = true
        checkAllFileds()
        if let username = userNameTextField.text{
            if username.count >= 3 && username.count <= 20{
                loginviewModel.checkUserNameForExsistingUser(userName: username) {
                    
                    DispatchQueue.main.async {
                        self.userNameUnderLineView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.6549019608, blue: 0.231372549, alpha: 1)
                        self.verifiedImg.isHidden = false
                        self.verifiedImg.image = #imageLiteral(resourceName: "icn_textfield_right-1")
                    }
                    
                } fail: {
                    DispatchQueue.main.async {
                        self.verifiedImg.isHidden = false
                        self.userNameUnderLineView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.1490196078, blue: 0.1490196078, alpha: 1)
                        self.verifiedImg.image = #imageLiteral(resourceName: "icn_textfield_wrong-1")
                    }
                    
                    
                }

            }
        }
    }
   
    
    @IBAction func passwordTextChangeOutlet(_ sender: Any) {
        checkAllFileds()
    }
    
   
    
    @IBAction func loginClick(_ sender: Any) {
    
        let loader = self.loader()
        loginviewModel.loginUser(userName: userNameTextField.text!, password: passwordTextfield.text!) { token in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                vc.mainShared.token = token
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } fail: {
            self.stopLoader(loader: loader)
            DispatchQueue.main.async {
                self.invalidPopup.isHidden=false
                //self.userNameTextField.text = ""
                self.passwordTextfield.text = ""
                self.invalidMessage.text = "Invalid credentials, please try again"
                self.passwordTextfield.becomeFirstResponder()
                
            }
            
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
    
    @IBAction func onClickRegister(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(identifier: "NewAccountViewController") as! NewAccountViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
