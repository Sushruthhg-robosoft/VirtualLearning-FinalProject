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
    override func viewDidLoad() {
//        mainShared.categoriesViewModelShared.listofCategories.removeAll()
        
        

        
       // print("sdcfewfdfeferrer\(userName)")
        self.hamburgerView.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hamburgerViewController?.delegate = self

        newUserDelegate.delegate = self
        NewUserView.delegate = self
        test.testDelegate = self
        popUpView.isHidden = true
        
        shared.delegate = self
        
        

        


    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loader1 = self.loader()
        NewUserView.topView.bannerImage.removeAll()
        print(NewUserView.topView.bannerImage.count)
        mainShared.homeViewModelShared.getBanners(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
               
                self.NewUserView.topView.bannerImage = data
                self.stopLoader(loader: loader1)
                self.NewUserView.topView.suggestionsCollectionView.reloadData()

            }
        } fail: {
           self.stopLoader(loader: loader1)
            print("fail")
        }
        
        NewUserView.isHidden = false

    }
    @IBAction func onClickSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController
        
        navigationController?.pushViewController(vc!, animated: true)
        

    }
    
    @IBAction func onClickNext(_ sender: Any) {
    }
    
    
    @IBAction func showHamburger(_ sender: Any) {
        self.hamburgerView.isHidden = false
        
        UIView.animate(withDuration: 0.1) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
           // self.backViewForHamburger.alpha = 0.75
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
//                self.isHamburgerMenuShown = true
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
            //self.backViewForHamburger.alpha = 0.0
            UIView.animate(withDuration: 0.1) {
                self.leadingConstraintForHamburgerView.constant = -312
                self.view.layoutIfNeeded()
            } completion: { (status) in
               // self.backViewForHamburger.isHidden = true
                //self.isHamburgerMenuShown = false
            }
        }
    }
}


extension HomeViewController: clickButtons{
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
    
    func onclickChooseInAllCourse() {
        let vc = storyboard?.instantiateViewController(identifier: "ChooseYourCourseViewController") as! ChooseYourCourseViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onClickCategory(categoryName: String, categoryId: String) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryName = categoryName
        vc.categoryId = categoryId
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

extension HomeViewController: test{
   
    
    func printHome() {
        print("yessss calledddd")
    }
    
    
}




