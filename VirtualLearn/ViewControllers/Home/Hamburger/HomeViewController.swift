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
    
    var banners = [String]()
    var userName: String?
    var shared = ViewModel.shared
    var mainShared = mainViewModel.mainShared
    var hamburgerViewController: HamburgerViewController?
    override func viewDidLoad() {
        
        
       // print("sdcfewfdfeferrer\(userName)")
        self.hamburgerView.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hamburgerViewController?.delegate = self
//        existingUserView.isHidden = false
//        NewUserView.isHidden = true
        newUserDelegate.delegate = self
        NewUserView.delegate = self
        test.testDelegate = self
        
        
        shared.delegate = self
        
        print(mainShared.homeViewModelShared.banners.count)
     
        let view = NewUserView.returnObj()
        print("Homevc: \(Unmanaged.passUnretained(view).toOpaque())")
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loader = self.loader()
        NewUserView.topView.bannerImage.removeAll()
        print(NewUserView.topView.bannerImage.count)
        mainShared.homeViewModelShared.getBanners { (data) in
            DispatchQueue.main.async {
               
                self.NewUserView.topView.bannerImage = data
                self.stopLoader(loader: loader)
                self.NewUserView.topView.suggestionsCollectionView.reloadData()

            }
        } fail: {
           self.stopLoader(loader: loader)
            print("fail")
        }
        
        
        mainShared.homeViewModelShared.getAllCourseDeatils { (data) in
        
        } fail: {
        
        }


    }
    @IBAction func onClickSearch(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController
        
        navigationController?.pushViewController(vc!, animated: true)
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
    func onClickChoiceofYourCourse() {
        
        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func onClickSeeAllCategories() {
       
       // newUserDelegate.delegate = self
        let vc = storyboard?.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}

extension HomeViewController: test{
   
    
    func printHome() {
        print("yessss calledddd")
    }
    
    
}




