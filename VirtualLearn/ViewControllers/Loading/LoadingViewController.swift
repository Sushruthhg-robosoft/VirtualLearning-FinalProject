//
//  LoadingViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import UIKit

class LoadingViewController: UIViewController {

    private var onboardingSeen: Bool!
    private let StorageManegr = StorageManeger.shared
    private var loggedIn: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        onboardingSeen = StorageManegr.isOnboardingSeen()
        loggedIn = StorageManegr.isLoggedIn()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if loggedIn{
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
            navigationController?.pushViewController(vc!, animated: false)
        }
        else{
            showvc()
        }
    }
    
    private func showvc(){
        
        if !onboardingSeen{
            let vc = storyboard?.instantiateViewController(identifier: "OnboardingViewController") as? OnboardingViewController
            navigationController?.pushViewController(vc!, animated: false)
        }
        else{
            let vc = storyboard?.instantiateViewController(identifier: "LandingViewController") as? LandingViewController
            navigationController?.pushViewController(vc!, animated: false)
        }
    }
}
