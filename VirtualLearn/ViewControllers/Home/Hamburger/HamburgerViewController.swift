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
    
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var backGroundProfileImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var notificationCount: customHamLable!
    
    var delegate: HamburgerViewControllerDelegate?
    var mainShraed = mainViewModel.mainShared
    @IBOutlet weak var loginBtn: customHabButtons!
    var storageManegr = StorageManeger.shared
    
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
        
        if storageManegr.isLoggedIn(){
            loginBtn.setTitle("Logout", for: .normal)
        }
        else{
            loginBtn.setTitle("Login", for: .normal)
        }
        mainShraed.profileViewModel.getProfileData(token: mainShraed.token) { (data) in
            DispatchQueue.main.async {
                self.occupation.text = data.occupation
                self.userName.text = data.fullName.capitalized
                let url = URL(string: data.profilePic!)
                guard let data = try? Data(contentsOf: url!) else {return}
                self.backGroundProfileImage.image = UIImage(data: (data))
                
                self.profileImage.image = UIImage(data: data)
            }
        } fail: {
            print("fail")
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
        
        if loginBtn.titleLabel?.text == "Logout"{
            let storageManger = StorageManeger.shared
            logoutMessagePopup(message: "Do you really want to logout?")
            
            storageManger.resetLoggedIn()
        }
        else{
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    func logoutMessagePopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let storageManger = StorageManeger.shared
            self.mainShraed.loginViewModel.logout(userId: storageManger.authId() , token: self.mainShraed.token)
            storageManger.resetLoggedIn()
            print(123456789,storageManger.isLoggedIn())
            let vc = self.storyboard?.instantiateViewController(identifier: "LoadingViewController") as? LoadingViewController
           self.navigationController?.popViewController(animated: true)
          //self.navigationController?.popToViewController(vc!, animated: true)
            
        })
        let no = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(no)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
