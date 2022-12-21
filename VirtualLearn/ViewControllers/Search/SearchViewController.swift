//
//  ViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 12/12/22.
//

import UIKit



class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstBtn: UIButton!
    
    @IBOutlet weak var secondBtn: UIButton!
    
    @IBOutlet weak var thirdBtn: UIButton!
    
    @IBOutlet weak var fourthBtn: UIButton!
    
    @IBOutlet weak var fifthBtn: UIButton!
    
    @IBOutlet weak var CourseDetailsTableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var InitialDisplayView: UIView!
    @IBOutlet weak var topSearchView: UIView!
    @IBOutlet weak var noDataDisplayView: UIView!
    @IBOutlet weak var CategoriesDisplayView: UIView!
    
    @IBOutlet weak var topSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataDisplayViewheight: NSLayoutConstraint!
    let shared = mainViewModel.mainShared


    override func viewDidLoad() {
        topSearchView.isHidden = true
            topSearchViewHeight.constant  = 0
        super.viewDidLoad()
        shared.searchViewModelShared.getTopSearches { (result) in
            print(result)
        } fail: { (error) in
            print("error")
        }
        
        searchTextField.delegate = self
        
        shared.categoriesViewModelShared.getCategories(token: shared.token) {
            DispatchQueue.main.async {
            }
        } fail: {
            print("error")
        }

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shared.searchViewModelShared.searchOption = searchTextField.text!
        shared.searchViewModelShared.getSearchResult { (result) in
                    print(result)
                } fail: { (fail) in
                    print(fail)
                }
        
        
        return true
    }
    

    @IBAction func filterButton(_ sender: Any) {
    
        
        let vc = storyboard?.instantiateViewController(identifier: "ModallyViewController") as? ModallyViewController
        
        present(vc!, animated: true, completion: nil)
        
        vc?.searchField = searchTextField.text!
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onclickSearchBtn(_ sender: Any) {
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
