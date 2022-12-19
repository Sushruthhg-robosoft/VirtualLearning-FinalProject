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
        mainShraed.notificationViewModelShared.getNotificationCount {
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
        mainShraed.notificationViewModelShared.getNotificationCount {
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
    
}
