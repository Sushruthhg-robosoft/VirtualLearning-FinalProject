//
//  EditProfileViewController.swift
//  ProfileScreen
//
//  Created by Anushree J C on 09/12/22.
//

import Foundation
import UIKit
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileNoField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var twitterField: UITextField!
    @IBOutlet weak var facebookField: UITextField!
    
    
    
    
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveLoadingButton: LoadingButton!
    
    
    var isdropDown = false
    var emailId = false
    
    var profileData: ProfileData?
    let profileViewModel = ProfileViewModel()
    let editProfileViewModel = EditProfileViewModel()
    let shared = mainViewModel.mainShared
    
    var dummyImage : UIImage?
    
    override func viewDidLoad() {
        
        nameField.delegate = self
        userNameField.delegate = self
        emailField.delegate = self
        genderField.delegate = self
        dateOfBirthField.delegate = self
        occupationField.delegate = self
        twitterField.delegate = self
        facebookField.delegate = self
        
        self.enableTextField()
        
        emailField.text = profileData?.emailId
        nameField.text = profileData?.fullName
        userNameField.text = profileData?.userName
        mobileNoField.text = profileData?.phoneNumber
        profilePhoto.image = dummyImage
        backgroundImage.image = dummyImage
        occupationField.text = profileData?.occupation
        dateOfBirthField.text = profileData?.dateOfBirth
        genderField.text = profileData?.gender
        twitterField.text = profileData?.twitterLink
        facebookField.text = profileData?.facebookLink
        
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = true
        
        dropDownView.isHidden = true
        genderField.isEnabled = false
        dropDownView.layer.cornerRadius = 5
        dropDownView.layer.borderWidth = 1
        dropDownView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        checkAllField()
        
        occupationLabel.isHidden = true
        genderLabel.isHidden = true
        dateOfBirth.isHidden = true
        twitterLabel.isHidden = true
        facebookLabel.isHidden = true
        
        
        
        
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)

            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height + 20
            scrollView.contentInset = contentInset
        }

        @objc func keyboardWillHide(notification:NSNotification) {

            scrollView.contentOffset = .zero
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
        self.disableTextField()
        
        //        let loader = self.loader()
        
        saveLoadingButton.showLoading()
        
        saveLoadingButton.isEnabled = false
        
        updateEditProfileData()
        
        editProfileViewModel.updateProfileData(profileImage: profilePhoto.image ??  #imageLiteral(resourceName: "icn_profile_menu"), token: shared.token, profiledata: profileData!) {
            print(4)
            DispatchQueue.main.async {
                print("inside dispatch que")
                self.saveLoadingButton.hideLoading()
                self.saveLoadingButton.isEnabled = true
                //            self.stopLoader(loader: loader)
                self.AlertMessagePopup(message: "Profile updated successfully")
                
            }
        } fail: { error in
            print("profile update error", error)
        }
    }
    
    func updateEditProfileData() {
        
        profileData?.emailId = emailField.text!
        profileData?.fullName =  nameField.text!
        profileData?.userName = userNameField.text!
        profileData?.phoneNumber = mobileNoField.text!
        profileData?.gender = genderField.text!
        profileData?.dateOfBirth = dateOfBirthField.text!
        profileData?.facebookLink = facebookField.text!
        profileData?.twitterLink = twitterField.text!
        profileData?.occupation = occupationField.text!
        
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    
    @IBAction func nameEdit(_ sender: Any) {
        nameView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        nameLabel.isHidden = false
        nameField.placeholder = ""
        
        
    }
    
    
    @IBAction func userNameEdit(_ sender: Any) {
        userNameView.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1)
        userNameLabel.isHidden = false
        userNameField.placeholder = ""
        
        
    }
    
    @IBAction func emailEdit(_ sender: Any) {
        
        emailView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        emailLabel.isHidden = false
        emailField.placeholder = ""
        emailId = !isValidEmail(email: emailField.text!)
        if emailId {
            okAlertMessagePopup(message: "Enter Valid Email")
            saveLoadingButton.isEnabled = false
            
        }
        
    }
    
    @IBAction func mobileNoEdit(_ sender: Any) {
        mobileNoView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        mobileNoLabel.isHidden = false
        mobileNoField.placeholder = ""
        
        
    }
    
    @IBAction func occupationEdit(_ sender: Any) {
        occupationLabel.isHidden = false
        occupationView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        occupationLabel.text = "Occupation"
        occupationField.placeholder = ""
        
    }
    @IBAction func occupationEndEditing(_ sender: Any) {
        occupationField.placeholder = "Occupation"
        occupationLabel.isHidden = true
    }
    
    @IBAction func genderEdit(_ sender: Any) {
        genderView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        genderLabel.isHidden = false
        genderField.placeholder = ""
       
    }
    
    @IBAction func genderEndEditing(_ sender: Any) {
        genderField.placeholder = "Gender"
        genderLabel.isHidden = true
    }
    @IBAction func dateOfBirthEdit(_ sender: Any) {
        dateOfBirthView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        dateOfBirth.isHidden = false
        dateOfBirthField.placeholder = ""
        
    }
    
    @IBAction func dataOfBirthDidEndEditing(_ sender: Any) {
        
        dateOfBirthField.placeholder = "Date Of Birth (YYYY-MM-DD)"
        dateOfBirth.isHidden = true
    }
    @IBAction func twitterFieldEdit(_ sender: Any) {
        twitterView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        twitterLabel.isHidden = false
        twitterField.placeholder = ""
        
    }
    
    @IBAction func twitterDidEndEditing(_ sender: Any) {
        twitterField.placeholder = "Twitter link"
        twitterLabel.isHidden = true
    }
    @IBAction func facebookFieldEdit(_ sender: Any) {
        facebookView.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        facebookLabel.isHidden = false
        facebookField.placeholder = ""
        
    }
    
    @IBAction func faceBookDidEndEditing(_ sender: Any) {
        facebookField.placeholder = "Facebook link"
        facebookLabel.isHidden = true
    }
    
    @IBAction func onClickDropdown(_ sender: Any) {
        
        dropDownView.isHidden = false
    }
    
    @IBAction func maleTapped(_ sender: Any) {
        
        genderField.text = maleGender.currentTitle
        dropDownView.isHidden = true
        checkAllField()
    }
    
    @IBAction func femaleTapped(_ sender: Any) {
        genderField.text = femaleGender.currentTitle
        dropDownView.isHidden = true
        checkAllField()
    }
    
    @IBAction func otherTapped(_ sender: Any) {
        genderField.text = otherGender.currentTitle
        dropDownView.isHidden = true
        checkAllField()
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
    
    func disableTextField(){
        self.nameField.isEnabled = false
        self.userNameField.isEnabled = false
        self.emailField.isEnabled = false
        self.mobileNoField.isEnabled = false
        self.occupationField.isEnabled = false
        self.genderField.isEnabled = false
        self.dateOfBirthField.isEnabled = false
        self.twitterField.isEnabled = false
        self.facebookField.isEnabled = false
    }
    func enableTextField(){
        self.nameField.isEnabled = true
        self.userNameField.isEnabled = true
        self.emailField.isEnabled = true
        self.mobileNoField.isEnabled = true
        self.occupationField.isEnabled = true
        self.genderField.isEnabled = true
        self.dateOfBirthField.isEnabled = true
        self.twitterField.isEnabled = true
        self.facebookField.isEnabled = true
    }
    
    @IBAction func emailIdEditing(_ sender: Any) {
        
    }
    
    
    @IBAction func nameEditingChanged(_ sender: Any) {
        guard  nameField != nil else {
            return
        }
        checkAllField()
        
    }
    
    @IBAction func userNameEditingChanged(_ sender: Any) {
        guard userNameField != nil else {
            return
        }
        checkAllField()
    }
    
    
    @IBAction func emailFieldEditingChanged(_ sender: Any) {
        emailId = isValidEmail(email: emailField.text!)
        if emailId {
            print(emailId)
            checkAllField()
        }
        else{
            saveLoadingButton.isEnabled = false
        }
        
        //        guard emailField != nil else {
        //            return
        //        }
        //        checkAllField()
    }
    
    
    
    @IBAction func mobileNumberEditingChanged(_ sender: Any) {
        guard mobileNoField != nil else {
            return
        }
        checkAllField()
    }
    
    
    @IBAction func occupationEditingChanged(_ sender: Any) {
        guard occupationField != nil else {
            return
        }
        checkAllField()
    }
    
    @IBAction func genderEditingChanged(_ sender: Any) {
        guard genderField != nil else {
            return
        }
        checkAllField()
    }
    
    
    @IBAction func dateOfBirthEditingChanged(_ sender: Any) {
        guard dateOfBirthField != nil else {
            return
        }
        checkAllField()
    }
    
    func checkAllField() {
        print("email",emailId)
        
        if (nameField.text != "" && userNameField.text != "" && emailField.text != "" && mobileNoField.text != "" && occupationField.text != "" && genderField.text != "" && dateOfBirthField.text != "")
        {
            saveLoadingButton.isEnabled = true
            saveLoadingButton.alpha = 1
            
            
        }
        else
        {
            saveLoadingButton.isEnabled = false
            saveLoadingButton.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == nameField {
                textField.resignFirstResponder()
                userNameField.becomeFirstResponder()
            }
            else if textField == userNameField {
                   textField.resignFirstResponder()
                emailField.becomeFirstResponder()
            }
            else if textField == emailField {
                   textField.resignFirstResponder()
                  mobileNoField.becomeFirstResponder()
            }
            else if textField == mobileNoField {
                   textField.resignFirstResponder()
                  occupationField.becomeFirstResponder()
            }
            else if textField == occupationField {
                   textField.resignFirstResponder()
                  genderField.becomeFirstResponder()
            }
            else if textField == genderField {
                   textField.resignFirstResponder()
                  dateOfBirthField.becomeFirstResponder()
            }
            else if textField == dateOfBirthField {
                   textField.resignFirstResponder()
                  twitterField.becomeFirstResponder()
            }
            
            else if textField == twitterField {
                   textField.resignFirstResponder()
                  facebookField.becomeFirstResponder()
            }
            else if textField == facebookField {
            textField.resignFirstResponder()
        }
        
            return true
        }
    }

extension EditProfileViewController {
    func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
       
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        
        view.endEditing(true)
    }
}






