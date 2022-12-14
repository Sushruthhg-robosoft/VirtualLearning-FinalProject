//
//  ViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 12/12/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var CourseDetailsTableView: UITableView!
    
    @IBOutlet weak var InitialDisplayView: UIView!
    @IBOutlet weak var topSearchView: UIView!
    @IBOutlet weak var noDataDisplayView: UIView!
    @IBOutlet weak var CategoriesDisplayView: UIView!
    
    @IBOutlet weak var topSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataDisplayViewheight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        topSearchView.isHidden = true
            topSearchViewHeight.constant  = 0
        super.viewDidLoad()
    }

    @IBAction func filterButton(_ sender: Any) {
        
        //resizeView.isHidden = false
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CourseDataTableViewCell

        return cell
    }
    
    
}
