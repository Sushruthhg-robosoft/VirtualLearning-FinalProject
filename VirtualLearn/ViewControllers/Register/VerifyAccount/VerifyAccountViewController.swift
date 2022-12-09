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
    var isForgotPassword : Bool = false
    var verificationText: String = ""
    @IBOutlet weak var verifyScreen: UIView!
    
    override func viewDidLoad() {
        invalidVerificationView.isHidden = true
        firstTextField.removeBorder()
        secondTextField.removeBorder()
        thirdTextField.removeBorder()
        fourthTextField.removeBorder()

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
        
        firstDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        secondDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        thirdDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        fourthDigitUnderView.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        
        invalidVerificationView.isHidden = false
        
        verifyScreen.isHidden = true
        successScreen.isHidden = false
        view.bringSubviewToFront(successScreen)


        if isForgotPassword {
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController

            navigationController?.pushViewController(vc, animated: true)
        }

        else{

        let vc = storyboard?.instantiateViewController(identifier: "PersonalDetailsViewController") as! PersonalDetailsViewController

        navigationController?.pushViewController(vc, animated: true)
        }
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

