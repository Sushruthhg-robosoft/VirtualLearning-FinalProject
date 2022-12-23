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
    let keychain = KeyChain()
    let shared = mainViewModel.mainShared
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        onboardingSeen = StorageManegr.isOnboardingSeen()
        loggedIn = StorageManegr.isLoggedIn()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loggedIn = StorageManegr.isLoggedIn()
        if loggedIn{
            
            let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
            let authId = StorageManegr.authId()
            guard let receivedTokenData = keychain.loadData(userId: String(authId)) else {return}
            guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else { return }
            shared.token = receivedToken
            print("token",receivedToken)
//            keychain.deletePassword(userId: authId, data: shared.token.data(using: .utf8)!)
            
            vc?.mainShared.token = receivedToken
            //vc?.mainShared.isExisting = true
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
