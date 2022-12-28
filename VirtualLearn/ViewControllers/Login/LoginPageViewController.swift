//
//  LoginPageViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 07/12/22.
//

import UIKit

class LoginPageViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var invalidPopup: UIView!
    @IBOutlet weak var invalidMessage: UILabel!
    @IBOutlet weak var userNameUnderLineView: UIView!
    @IBOutlet weak var passwordUnderLineView: UIView!
    @IBOutlet weak var verifiedImg: UIImageView!
    
    var isPresented: Bool = false
    let loginviewModel = LoginViewModel()
    let shared = mainViewModel.mainShared
    let storageManeger = StorageManeger.shared
    
    var activeTextField : UITextField? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextfield.delegate = self
        
        initializeHideKeyboard()
        
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        invalidPopup.isHidden = true
        userNameTextField.becomeFirstResponder()
        verifiedImg.isHidden = true
        userNameUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        passwordUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        

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
 

    
    @IBAction func userNameTextChangeOutlet(_ sender: Any) {
        invalidPopup.isHidden = true
        checkAllFileds()
        if let username = userNameTextField.text{
            if username.count >= 3 && username.count <= 20{
                loginviewModel.checkUserNameForExsistingUser(userName: username) { givenUsername in                    
                    DispatchQueue.main.async {
                        self.userNameUnderLineView.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.6549019608, blue: 0.231372549, alpha: 1)
                        self.verifiedImg.isHidden = false
                        self.verifiedImg.image = #imageLiteral(resourceName: "icn_textfield_right-1")
                    }
                    
                } fail: {
                    
                    givenUsername in
                    
                    print("\(givenUsername) failed")
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
                self.storageManeger.setLoggedIn()
                
            }
        } fail: {
            self.stopLoader(loader: loader)
            DispatchQueue.main.async {
                self.invalidPopup.isHidden=false
                //self.userNameTextField.text = ""
                self.passwordTextfield.text = ""
                self.invalidMessage.text = "Invalid credentials, please try again"
                self.passwordTextfield.becomeFirstResponder()
                self.storageManeger.resetLoggedIn()
                
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

    

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            textField.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
        }
        else if textField == passwordTextfield {
               textField.resignFirstResponder()
        }
        return true
    }
}


