//
//  TermConditionViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 13/12/22.
//

import UIKit

class TermConditionViewController: UIViewController {
    let privacyViewModel = PrivacyPolicyViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loader = self.loader()
        privacyViewModel.getprivacyPolicyContent(privacyPolicyId: "1") {
        DispatchQueue.main.async {
        self.stopLoader(loader: loader)
        }
            
        } fail: {
            print("failure")
        }
    }
    

    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

