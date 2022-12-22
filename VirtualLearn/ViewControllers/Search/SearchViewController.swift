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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var InitialDisplayView: UIView!
    @IBOutlet weak var topSearchView: UIView!
    @IBOutlet weak var noDataDisplayView: UIView!
    @IBOutlet weak var CategoriesDisplayView: UIView!
    
    @IBOutlet weak var topSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataDisplayViewheight: NSLayoutConstraint!
    let shared = mainViewModel.mainShared
    
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        topSearchView.isHidden = false
        
        //            topSearchViewHeight.constant  = 0
        noDataDisplayView.isHidden = true
        noDataDisplayViewheight.constant = 0
        
        super.viewDidLoad()
        shared.searchViewModelShared.getTopSearches { (result) in
            DispatchQueue.main.async {
                print(self.shared.searchViewModelShared.topSearches)
                self.firstBtn.setTitle(self.shared.searchViewModelShared.topSearches[0], for: .normal)
                self.secondBtn.setTitle(self.shared.searchViewModelShared.topSearches[1], for: .normal)
                self.thirdBtn.setTitle(self.shared.searchViewModelShared.topSearches[2], for: .normal)
                self.fourthBtn.setTitle(self.shared.searchViewModelShared.topSearches[3], for: .normal)
                self.fifthBtn.setTitle(self.shared.searchViewModelShared.topSearches[4], for: .normal)
                
            }
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
    
    
    @IBAction func textFieldDIdChangeEditing(_ sender: Any) {
        shared.searchViewModelShared.searchOption = searchTextField.text!
                shared.searchViewModelShared.getSearchResult { (result) in
                    DispatchQueue.main.async {
                        
                        if result.count != 0 {
                            
                            self.topSearchView.isHidden = true
                            self.noDataDisplayView.isHidden = true
                            self.CategoriesDisplayView.isHidden = true
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayViewheight.constant = 0
                            self.tableView.isHidden = false
                            self.tableView.reloadData()

                            
                        }else {
                            self.tableView.isHidden = true
                            self.topSearchView.isHidden = true
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayView.isHidden = false
                            self.noDataDisplayViewheight.constant = 417
                            
                        }
                    }
                } fail: { (fail) in
                }
        shared.searchViewModelShared.getAutoSearch(autoFill: self.searchTextField.text!) { (result) in
                                  
                                  DispatchQueue.main.async {
                                     
                                    self.searchTextField.placeholder = result
                                }
                        
                              } fail: { (result) in
                                  print(result)
                              }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
        return true
    }
    
    
    @IBAction func filterButton(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(identifier: "ModallyViewController") as? ModallyViewController
        
        present(vc!, animated: true, completion: nil)
        
        vc?.searchField = searchTextField.text!
        vc?.delegate = self
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onclickSearchBtn(_ sender: Any) {
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shared.searchViewModelShared.searchResult.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CourseDataTableViewCell
        
        cell.categoryName.text = shared.searchViewModelShared.searchResult[indexPath.row].categoryName
        cell.courseName.text = shared.searchViewModelShared.searchResult[indexPath.row].courseName
        
        let url = URL(string: shared.searchViewModelShared.searchResult[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        
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


extension SearchViewController: SearchResponse {
    func modallySearchResult() {
        self.topSearchView.isHidden = true
        self.noDataDisplayView.isHidden = true
        self.CategoriesDisplayView.isHidden = true
        self.topSearchViewHeight.constant = 0
        self.noDataDisplayViewheight.constant = 0
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func modallyNil() {
        self.tableView.isHidden = true
        self.topSearchView.isHidden = true
        self.topSearchViewHeight.constant = 0
        self.noDataDisplayView.isHidden = false
        self.noDataDisplayViewheight.constant = 417
    }
    
    
}
