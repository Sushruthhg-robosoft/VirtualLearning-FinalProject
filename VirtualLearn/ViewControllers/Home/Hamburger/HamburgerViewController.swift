//
//  HamburgerViewController.swift
//  hamburger
//
//  Created by Manish R T on 07/12/22.
//

import UIKit

protocol HamburgerViewControllerDelegate {
    func hideHamburgerMenu()
}

class HamburgerViewController: UIViewController {

    @IBOutlet weak var notificationCount: customHamLable!
    var delegate: HamburgerViewControllerDelegate?
    var mainShraed = mainViewModel.mainShared
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let loader = self.loader()
        print("insideHamburgerMenu")
        mainShraed.notificationViewModelShared.getNotificationCount( token: mainShraed.token){
            print("slfdhoifhfdidsdnieohiodhdfhsi")
            DispatchQueue.main.async {
                //self.stopLoader(loader: loader)
                self.notificationCount.text = String(self.mainShraed.notificationViewModelShared.count)
            }
        } fail: {
           // self.stopLoader(loader: loader)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loader = self.loader()
        mainShraed.notificationViewModelShared.getNotificationCount(token: mainShraed.token){
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.notificationCount.text = String(self.mainShraed.notificationViewModelShared.count)
            }
        } fail: {
            self.stopLoader(loader: loader)
        }

    }
    
    @IBAction func onClickHome(_ sender: Any) {
        
        print("Clicked")
        self.delegate?.hideHamburgerMenu()
    }
    

    @IBAction func onClickMyCourse(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "MyCourseViewController") as! MyCourseViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickMyProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
 
    
    @IBAction func onClickNotifications(_ sender: Any) {
        
        print("clicked notification")
        let vc = storyboard?.instantiateViewController(identifier: "NotificationViewController") as! NotificationViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickSettings(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "SettingViewController") as! SettingViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickLogOut(_ sender: Any) {
       
        logoutMessagePopup(message: "Do you really want to logout?")
        
        
    }
    
    
    func logoutMessagePopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let storageManger = StorageManeger.shared
            self.mainShraed.loginViewModel.logout(userId: storageManger.authId() , token: self.mainShraed.token)
            storageManger.resetLoggedIn()
            let vc = self.storyboard?.instantiateViewController(identifier: "LandingViewController") as? LandingViewController
            self.navigationController?.pushViewController(vc!, animated: true)
         })
        let no = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
         })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(no)

        self.present(dialogMessage, animated: true, completion: nil)
    }
}
