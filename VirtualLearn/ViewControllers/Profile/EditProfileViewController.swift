//
//  EditProfileViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 09/12/22.
//

import Foundation
import UIKit
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var backgroundProfile: UIView!
    @IBOutlet weak var profilePhoto: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var facebookLabel: UILabel!
    
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNoField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileNoView: UIView!
    @IBOutlet weak var occupationView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var dateOfBirthView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var maleGender: UIButton!
    @IBOutlet weak var femaleGender: UIButton!
    @IBOutlet weak var otherGender: UIButton!
    
    var isdropDown = false
//    var dummyname = ""
//    var dummyUsername = ""
//    var dummyEmail = ""
//    var dummyMobileNo = ""
//    var dummydateofbirth = ""
//    var dummyusername = ""
     
    var profileData: ProfileData?
    let profileViewModel = ProfileViewModel()
    let editProfileViewModel = EditProfileViewModel()
    
   
    let shared = mainViewModel.mainShared
    
    override func viewDidLoad() {
        
        emailField.text = profileData?.emailId
        nameField.text = profileData?.fullName
        userNameTextField.text = profileData?.userName
        mobileNoField.text = profileData?.phoneNumber
        

        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        dropDownView.isHidden = true
        genderField.isEnabled = false
        dropDownView.layer.cornerRadius = 5
        dropDownView.layer.borderWidth = 1
        dropDownView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       
    }
    
    
    @IBAction func onClickCameraButton(_ sender: Any) {
        let imageController = UIImagePickerController()
                imageController.delegate = self
                imageController.sourceType = .photoLibrary
                self.present(imageController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        profilePhoto.image = info[.originalImage] as? UIImage

            self.dismiss(animated: true, completion: nil)

        }
    
    @IBAction func onClickSaveBtn(_ sender: Any) {
       // let loader = self.loader()
        updateEditProfileData()
        editProfileViewModel.updateProfileData(token: shared.token, profiledata: profileData!) {
            
            
            DispatchQueue.main.async {
            //self.stopLoader(loader: loader)
                self.AlertMessagePopup(message: "Profile updated successfully")
                            
            }
            } fail: {
                
                
            }
    }
       
            func updateEditProfileData() {
                
                
                
                profileData?.emailId = emailField.text!
                profileData?.fullName =  nameField.text!
                profileData?.userName = userNameTextField.text!
                profileData?.phoneNumber = mobileNoField.text!
                profileData?.gender = genderField.text!
                profileData?.dateOfBirth = dateOfBirth.text!
                profileData?.facebookLink = facebookField.text!
                profileData?.twitterLink = twitterField.text!
                profileData?.occupation = occupationField.text!
                
            }
    
    @IBAction func nameEdit(_ sender: Any) {
        nameView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    
    @IBAction func userNameEdit(_ sender: Any) {
        userNameView.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
    }
    
    @IBAction func emailEdit(_ sender: Any) {
        emailView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    @IBAction func mobileNoEdit(_ sender: Any) {
        mobileNoView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    @IBAction func occupationEdit(_ sender: Any) {
        occupationView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    @IBAction func genderEdit(_ sender: Any) {
        genderView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    @IBAction func dateOfBirthEdit(_ sender: Any) {
        dateOfBirthView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    @IBAction func twitterFieldEdit(_ sender: Any) {
        twitterView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }

    @IBAction func facebookFieldEdit(_ sender: Any) {
        facebookView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
    }
    
    
    @IBAction func onClickDropdown(_ sender: Any) {
        
        dropDownView.isHidden = false
    }

    @IBAction func maleTapped(_ sender: Any) {
        
        genderField.text = maleGender.currentTitle
        dropDownView.isHidden = true
    }
    
    @IBAction func femaleTapped(_ sender: Any) {
        genderField.text = femaleGender.currentTitle
        dropDownView.isHidden = true
    }
    
    @IBAction func otherTapped(_ sender: Any) {
        genderField.text = otherGender.currentTitle
        dropDownView.isHidden = true
    }
 
        
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func AlertMessagePopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Congrats!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
         })
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
    }
        
    
}
