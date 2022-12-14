//
//  ViewController.swift
//  hamburger
//
//  Created by Manish R T on 07/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hamburgerView: UIView!
    @IBOutlet weak var leadingConstraintForHamburgerView: NSLayoutConstraint!
    
    @IBOutlet weak var NewUserView: NewUserHomeView!
    var test = NewUserHomeView()
    var newUserDelegate = NewUserBottomView()
    var profileDelegate = ProfileViewController()
    @IBOutlet weak var existingUserView: ExistingUserBottomview!
    
    @IBOutlet weak var popUpView: customPopHomeView!
    var banners = [String]()
    var userName: String?
    var shared = ViewModel.shared
    var mainShared = mainViewModel.mainShared
    var hamburgerViewController: HamburgerViewController?
    var storageShared = StorageManeger.shared
    override func viewDidLoad() {
        
        self.hamburgerView.isHidden = true
        super.viewDidLoad()
        
        hamburgerViewController?.delegate = self
        
        newUserDelegate.delegate = self
        NewUserView.delegate = self
        test.testDelegate = self
        popUpView.isHidden = true
        shared.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !storageShared.isLoggedIn(){
            let loader3 = self.loader()
            self.mainShared.homeViewModelShared.getBanners(token: self.mainShared.token) { (data) in
                DispatchQueue.main.async {
                    
                    self.NewUserView.topView.bannerImage = data
                    self.stopLoader(loader: loader3)
                    self.NewUserView.topView.suggestionsCollectionView.reloadData()
                    
                }
            } fail: {error in
            }
        }
        let loader = self.loader()
        mainShared.homeViewModelShared.getPersonalDetailsStatus(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                if data == "true"{
                    self.popUpView.isHidden = true
                    let loader1 = self.loader()
                    self.NewUserView.topView.bannerImage.removeAll()
                    
                    self.mainShared.homeViewModelShared.getBanners(token: self.mainShared.token) { (data) in
                        DispatchQueue.main.async {
                            self.stopLoader(loader: loader1)
                            self.NewUserView.topView.bannerImage = data
                            
                            self.NewUserView.topView.suggestionsCollectionView.reloadData()
                            
                        }
                    } fail: {error in
                        self.stopLoader(loader: loader1)
                    }
                }
                else{
                    self.popUpView.isHidden = false
                    let loader1 = self.loader()
                    self.NewUserView.topView.bannerImage.removeAll()
                    
                    self.mainShared.homeViewModelShared.getBanners(token: self.mainShared.token) { (data) in
                        DispatchQueue.main.async {
                            self.stopLoader(loader: loader1)
                            self.NewUserView.topView.bannerImage = data
                            
                            self.NewUserView.topView.suggestionsCollectionView.reloadData()
                            
                        }
                    } fail: {error in
                        self.stopLoader(loader: loader1)
                    }
                }
            }
            
        } fail: { (error) in
            self.stopLoader(loader: loader)
            DispatchQueue.main.async {
                print()
                if error == "401"{
                    if self.storageShared.isLoggedIn(){
                        self.errorPopup(message: "Your session has expired, please Login")
                    }
                    
                }
            }
        }
        NewUserView.isHidden = false
        
        
        
    }
    @IBAction func onClickSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController
        
        navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func showHamburger(_ sender: Any) {
        self.hamburgerView.isHidden = false
        
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                
            }
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "hamburgerSegue")
        {
            if let controller = segue.destination as? HamburgerViewController
            {
                self.hamburgerViewController = controller
                self.hamburgerViewController?.delegate = self
            }
        }
    }
    
}


extension HomeViewController: HamburgerViewControllerDelegate{
    
    func hideHamburgerMenu() {
        hamburgerView.isHidden = true
        hideHamburgerView()
    }
    
    
    private func hideHamburgerView()
    {
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = -312
                self.view.layoutIfNeeded()
            } completion: { (status) in
                
            }
        }
    }
}


extension HomeViewController: clickButtons{
    func onclickChooseInAllCourse(isNewest: Bool, isPopular: Bool, isAllCourse: Bool) {
        let vc = storyboard?.instantiateViewController(identifier: "ChooseYourCourseViewController") as! ChooseYourCourseViewController
        
        if isNewest{
            vc.newestCourse()
        }
        else if isPopular{
            vc.popularCourse()
        }
        else if isAllCourse{
            vc.allCourse()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onClickChoiceofYourCourse(courseId: String) {
        
        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.courseId = courseId
    }
    
    func onClickSeeAllCategories() {
        
        // newUserDelegate.delegate = self
        let vc = storyboard?.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func onClickCategory(categoryName: String, categoryId: String) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryName = categoryName
        vc.categoryId = categoryId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func errorPopup(message: String){
        
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            
            self.navigationController?.popToRootViewController(animated: true)
            self.storageShared.resetLoggedIn()
        })
        dialogMessage.addAction(ok)
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    
    
}

extension HomeViewController: test{
    
    
    func printHome() {
        
    }
    
    
}




