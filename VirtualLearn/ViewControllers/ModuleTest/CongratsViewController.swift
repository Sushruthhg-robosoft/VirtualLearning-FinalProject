//
//  CongratsViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import UIKit

class CongratsViewController: UIViewController {

    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(view.bounds.height > 500) {
            scrollViewHeight.constant = view.bounds.height
        // Do any additional setup after loading the view.
    }

}
}
