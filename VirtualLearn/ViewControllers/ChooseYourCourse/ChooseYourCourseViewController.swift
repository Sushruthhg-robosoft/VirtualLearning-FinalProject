//
//  ChooseYourCourseViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class ChooseYourCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: customChooseCourseView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.searchView.setBorder()
        self.searchTextField.removeBorder()
        super.viewDidLoad()

    }
    
}

extension ChooseYourCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseYourCourseTableViewCell
        
        return cell
    }
    
    
    
}


