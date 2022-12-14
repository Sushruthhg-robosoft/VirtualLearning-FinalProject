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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onClickChangePassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ChangeYourPasswordViewController") as! ChangeYourPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func onClickEditProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickHamburger(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

