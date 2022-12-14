//
//  VerifyAccountViewController.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 06/12/22.
//

import UIKit

class VerifyAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstDigitUnderView: UIView!
    @IBOutlet weak var secondDigitUnderView: UIView!
    @IBOutlet weak var thirdDigitUnderView: UIView!
    @IBOutlet weak var fourthDigitUnderView: UIView!
    
    @IBOutlet weak var successScreen: UIView!
    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var thirdTextField: UITextField!
    
    @IBOutlet weak var fourthTextField: UITextField!
    
    @IBOutlet weak var invalidVerificationView: UIView!
    
    @IBOutlet weak var verifylabel: UILabel!
    var mobileNumber = ""
    var isForgotPassword : Bool = false
    var verificationText: String = ""
    @IBOutlet weak var verifyScreen: UIView!
    let verificationOTP = VerificationOTP()
    
    override func viewDidLoad() {
        invalidVerificationView.isHidden = true
        firstTextField.removeBorder()
        secondTextField.removeBorder()
        thirdTextField.removeBorder()
        fourthTextField.removeBorder()
        
        firstTextField.becomeFirstResponder()

        super.viewDidLoad()
        
        successScreen.isHidden = true
        verifyScreen.isHidden = false
//        view.bringSubviewToFront(verifyScreen)
        
        firstTextField.delegate = self
        secondTextField.delegate = self
       thirdTextField.delegate = self

       fourthTextField.delegate = self

                

                firstTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

                secondTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

                thirdTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)

                fourthTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        if isForgotPassword {
            verifylabel.text = verificationText
        }
        
        
        
        

    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickVerify(_ sender: Any) {
        
        let loader = self.loader()
        guard let firstNumber = firstTextField.text else {return}
        guard let secondNumber = secondTextField.text else {return}
        guard let thirdNumber = thirdTextField.text else {return}
        guard let fourthNumber = fourthTextField.text else {return}
        
        let otp = firstNumber + secondNumber + thirdNumber + fourthNumber

        verificationOTP.verifyOTP(mobileNumber: "+917022011412", otp: otp){ sucess in
            
            DispatchQueue.main.async {
                self.correctOtp()
                self.stopLoader(loader: loader)
            if self.isForgotPassword {
                
                let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            else{
                let vc = self.storyboard?.instantiateViewController(identifier: "PersonalDetailsViewController") as! PersonalDetailsViewController
                vc.enterdMobileNumber = self.mobileNumber
                self.navigationController?.pushViewController(vc, animated: true)
            }
            }
            
        } fail: {fail in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.invalidVerificationView.isHidden = false
                self.firstDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
                self.secondDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
                self.thirdDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
                self.fourthDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
                
                self.firstTextField.text = ""
                self.secondTextField.text = ""
                self.thirdTextField.text = ""
                self.fourthTextField.text = ""
            }
        }
    }
    
    func correctOtp(){
        self.invalidVerificationView.isHidden = false
        self.firstDigitUnderView.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        self.secondDigitUnderView.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        self.thirdDigitUnderView.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        self.fourthDigitUnderView.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
    }
    @IBAction func resendOTPButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "LoginPageViewController") as! LoginPageViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func textFieldDidChange(textField: UITextField){
           guard let text = textField.text else {

               return

           }

           print(text)



           if text.count == 1 {

               switch textField

               {

               case firstTextField:

                   secondTextField.becomeFirstResponder()

               case secondTextField:

                   thirdTextField.becomeFirstResponder()

               case thirdTextField:

                   fourthTextField.becomeFirstResponder()

               case fourthTextField:

                   fourthTextField.resignFirstResponder()

               default:

                   break

               }

           }else{



           }

       }
}

