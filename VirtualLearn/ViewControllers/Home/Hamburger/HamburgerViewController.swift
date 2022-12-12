//
//  HamburgerViewController.swift
//  hamburger
//
//  Created by Manish R T on 07/12/22.
//

import UIKit

protocol HamburgerViewControllerDelegate {
    func hideHamburgerMenu()
}

class HamburgerViewController: UIViewController {

    var delegate: HamburgerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onClickHome(_ sender: Any) {
        
        print("Clicked")
        self.delegate?.hideHamburgerMenu()
    }
    

    @IBAction func onClickMyCourse(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "MyCourseViewController") as! MyCourseViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickMyProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
