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
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
    
    
    
    @IBAction func onClickDesign(_ sender: Any) {
    }
    
    @IBAction func onClickDevelopment(_ sender: Any) {
    }
    
    @IBAction func onClickBusiness(_ sender: Any) {
    }
    
    @IBAction func onClickFinance(_ sender: Any) {
    }
    
    @IBAction func onClickHealthFitness(_ sender: Any) {
    }
    
    @IBAction func onClickMusic(_ sender: Any) {
    }
    
    @IBAction func onClickIT(_ sender: Any) {
    }
    
    @IBAction func onClickMarketing(_ sender: Any) {
    }
    
    @IBAction func onClickLifestyle(_ sender: Any) {
    }
    
    @IBAction func onClickPhotography(_ sender: Any) {
    }
    
    @IBAction func onClickTeaching(_ sender: Any) {
    }
    
}
