//
//  ViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 08/12/22.
//

import UIKit



class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var hamburgerMenu: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var noOfCourses: UILabel!
    @IBOutlet weak var noOfChapters: UILabel!
    @IBOutlet weak var noOfTests: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var occupation: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var coursesView: UIView!
    @IBOutlet weak var chaptersView: UIView!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var changeYourPasswordButton: UIButton!
    
    var password = ""
    var oldpassword = ""

    let profileViewModel = ProfileViewModel()
    var profiledata : ProfileData?
    let shared = mainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loader = self.loader()
        profileViewModel.getProfileData(token:shared.token ) { profiledata in
            DispatchQueue.main.async {
                self.profiledata = profiledata
                self.stopLoader(loader: loader)
                self.profileName.text = profiledata.fullName
                self.name.text = profiledata.fullName
                self.userName.text = profiledata.userName
                self.email.text = profiledata.emailId
                self.mobileNumber.text = profiledata.phoneNumber
                self.dateOfBirth.text = profiledata.dateOfBirth
                self.occupation.text = profiledata.occupation
                self.noOfChapters.text = String(profiledata.numberOfChaptersCompleted)
                self.noOfCourses.text = String(profiledata.numberOfCoursesCompleted)
                self.noOfTests.text = String(profiledata.numberOfTestsAttempted)
            
            }
            
            
        } fail: {
            
        }
    }
    
    
    @IBAction func onClickChangePassword(_ sender: Any) {

        let vc = storyboard?.instantiateViewController(identifier: "ChangeYourPasswordViewController") as! ChangeYourPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
        }
    
    @IBAction func onClickEditProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(vc, animated: true)
//        vc.dummyEmail = email.text!
//        vc.dummyname = name.text!
//        vc.dummyusername = userName.text!
//        vc.dummyusername = userName.text!
//        vc.dummyMobileNo = mobileNumber.text!
        vc.profileData = profiledata
    }
    
    @IBAction func onClickHamburger(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
  
}

