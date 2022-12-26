//
//  LandingViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var termsOfServices: UIButton!
    @IBOutlet weak var privacyPolicy: UIButton!
    let storageManeger = StorageManeger.shared
    
    let privacyViewModel = PrivacyPolicyViewModel()
    let termsOfServiceViewModel = TermsOfServicesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerBtn.setBorder()
    }
    
    @IBAction func onClickSkip(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        navigationController?.pushViewController(vc!, animated: true)
        
        storageManeger.setGuestUser()
    }
    
    
    @IBAction func onClickRegister(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "NewAccountViewController") as! NewAccountViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "LoginPageViewController") as! LoginPageViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickTermsofServices(_ sender: Any) {
        let loader = self.loader()
        
        termsOfServiceViewModel.gettermsofServicesContent(termsOfServicesId: "1") { ServiceData in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                let vc = self.storyboard?.instantiateViewController(identifier: "TermConditionViewController") as! TermConditionViewController
                vc.label = "Terms Of Services"
                vc.content = ServiceData.content
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
        } fail: {
            print("gettermsofServicesContent error")
        }
        
        
    }
    
    @IBAction func onClickPrivacyPolicy(_ sender: Any) {
        let loader = self.loader()
        
        privacyViewModel.getprivacyPolicyContent(privacyPolicyId: "1") { PolicyData in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                let vc = self.storyboard?.instantiateViewController(identifier: "TermConditionViewController") as! TermConditionViewController
                vc.label = "Privacy Policy"
                vc.content = PolicyData.content
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        } fail: {
            print("getprivacyPolicyContent error")
        }
    }
}
