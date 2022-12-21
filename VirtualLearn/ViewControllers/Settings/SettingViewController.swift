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
    
    @IBOutlet weak var pushNotificationBtn: UIButton!
    
    @IBOutlet weak var notificationSoundBtn: UIButton!
    
    
    var isPushNotification = true
    var isNotificationSound = true
    
    let privacyViewModel = PrivacyPolicyViewModel()
    let privacyPolicyModel = [PrivacyPolicyModel]()
    let termsOfServiceViewModel = TermsOfServicesViewModel()
    let termsOfServiceModel = [TermsOfServicesModel]()

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
        
        privacyViewModel.getprivacyPolicyContent(privacyPolicyId: "1") { PolicyData in
        DispatchQueue.main.async {
            self.stopLoader(loader: loader)
            let vc = self.storyboard?.instantiateViewController(identifier: "TermConditionViewController") as! TermConditionViewController
            vc.label = "Privacy Policy"
            vc.content = PolicyData.content
            self.navigationController?.pushViewController(vc, animated: true)
            
        }

        } fail: {
            print("error")
        }
    }


    @IBAction func termsandConditionCliked(_ sender: Any) {
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
            print("error")
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickPushNotification(_ sender: Any) {
        
        if isPushNotification {
            self.pushNotificationBtn.setImage(#imageLiteral(resourceName: "btn_off copy"), for: .normal)
            self.isPushNotification = false
        }
        else{
            self.pushNotificationBtn.setImage(#imageLiteral(resourceName: "btn_on"), for: .normal)
            self.isPushNotification = true
        }
    }
    
    @IBAction func onClickNotificationSound(_ sender: Any) {
        
        if isNotificationSound {
            self.notificationSoundBtn.setImage(#imageLiteral(resourceName: "btn_off copy"), for: .normal)
            self.isNotificationSound = false
        }
        else{
            self.notificationSoundBtn.setImage(#imageLiteral(resourceName: "btn_on"), for: .normal)
            self.isNotificationSound = true
        }
    }
}


