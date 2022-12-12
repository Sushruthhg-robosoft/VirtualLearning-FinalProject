//
//  ViewController.swift
//  CreatePasswordScreens
//
//  Created by Anushree J C on 07/12/22.
//

import UIKit
class CreateNewPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var newPasswordline: UIView!
    @IBOutlet weak var confirmPasswordLine: UIView!
    override func viewDidLoad() {
 
        super.viewDidLoad()
        passwordView.isHidden = true
        passwordView.layer.cornerRadius = 10
        passwordView.layer.borderWidth = 1
        

    }
    
    @IBAction func passwordChangedBegin(_ sender: Any) {
        newPasswordline.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
        passwordView.isHidden = true

    }
    
    @IBAction func confirmPasswordChangedBegin(_ sender: Any) {
        confirmPasswordLine.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
    }
    
    @IBAction func passwordEditing(_ sender: Any) {
        
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
}
