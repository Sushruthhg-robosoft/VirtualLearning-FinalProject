//
//  CongratsViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import UIKit
protocol ReloadData {
    func reloadData()
}

class CongratsViewController: UIViewController {

    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    var assignmentId = ""
    var coursename = ""
    @IBOutlet weak var courseName: UILabel!
    var chapterDelegate : ChaptersViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        if(view.bounds.height > 500) {
            scrollViewHeight.constant = view.bounds.height
    }
        courseName.text = coursename
        
        

}
    
    @IBAction func onclickResult(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "TestResultViewController") as? TestResultViewController else {return}
        navigationController?.pushViewController(vc, animated: true)
        vc.assignmentId = self.assignmentId
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        chapterDelegate?.reloadData()
    }
}
