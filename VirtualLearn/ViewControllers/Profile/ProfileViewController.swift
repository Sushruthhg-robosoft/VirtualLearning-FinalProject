//
//  ViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 08/12/22.
//

import UIKit

protocol setProfileDetailsInHam{
    
    func setProfileValues(profileImage: UIImage, username: String, designation: String)
}


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
    var delgate: setProfileDetailsInHam?
    
    var password = ""
    var oldpassword = ""

     
    var profiledata : ProfileData?
    let shared = mainViewModel.mainShared
    
    var image : UIImage?
    var dummyBackgroundImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loader = self.loader()
        shared.profileViewModel.getProfileData(token:shared.token) { profiledata in
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
                let url = URL(string: profiledata.profilePic!)
                print(profiledata.profilePic)
                guard let data = try? Data(contentsOf: url!) else {return}
                self.profilePhoto.image = UIImage(data: (data))
                self.image = UIImage(data: data)
                self.profilePicture.image = UIImage(data: (data))
                self.dummyBackgroundImage = UIImage(data: (data))
                
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
        vc.dummyImage = image
        vc.profileData = profiledata
    }
    
    @IBAction func onClickHamburger(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func AlertMessagePopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Please login first!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
         })
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
}

