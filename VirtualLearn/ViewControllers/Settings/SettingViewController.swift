//
//  SettingViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 13/12/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var notificationSettingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var notificationSettingPopUpView: UIView!
    
    @IBOutlet weak var pushNotificationView: UIView!
    @IBOutlet weak var pushNotoficationViewheight: NSLayoutConstraint!
    @IBOutlet weak var notificationSoundView: UIView!
    @IBOutlet weak var notificationSoundViewHeight: NSLayoutConstraint!
    @IBOutlet weak var PopUpViewTopViewHeight: NSLayoutConstraint!
    
    let privacyViewModel = PrivacyPolicyViewModel()
//    let privacyPolicyModel = [PrivacyPolicyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationSettingPopUpView.isHidden = true
        self.notificationSettingViewHeight.constant = 0
        self.pushNotificationView.isHidden = true
        self.pushNotoficationViewheight.constant = 0
        self.notificationSoundView.isHidden = true
        self.notificationSoundViewHeight.constant = 0
        PopUpViewTopViewHeight.constant = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func notificationSettingClicked(_ sender: Any) {
        if(notificationSettingPopUpView.isHidden) {
            notificationSettingPopUpView.isHidden = false
        self.notificationSettingViewHeight.constant = 62
            self.pushNotificationView.isHidden = false
            self.pushNotoficationViewheight.constant = 22
            self.notificationSoundView.isHidden = false
            self.notificationSoundViewHeight.constant = 22
            PopUpViewTopViewHeight.constant = 19
        }
        else {
            notificationSettingPopUpView.isHidden = true
            self.notificationSettingViewHeight.constant = 0
            self.pushNotificationView.isHidden = true
            self.pushNotoficationViewheight.constant = 0
            self.notificationSoundView.isHidden = true
            self.notificationSoundViewHeight.constant = 0
            PopUpViewTopViewHeight.constant = 0
            
        }
    }
    
    @IBAction func privacyPolicyClicked(_ sender: Any) {
        let loader = self.loader()
        let vc = storyboard?.instantiateViewController(identifier: "TermConditionViewController") as! TermConditionViewController
        navigationController?.pushViewController(vc, animated: true)
        privacyViewModel.getprivacyPolicyContent(privacyPolicyId: "1") {
        DispatchQueue.main.async {
        
        self.stopLoader(loader: loader)

        }
            
        } fail: {
            print("error")
        }
    }
           


    
    @IBAction func termsandConditionCliked(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TermConditionViewController") as! TermConditionViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
