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
    
    @IBOutlet weak var categoriesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topSearchViewHeight: NSLayoutConstraint!
    @IBOutlet weak var noDataDisplayViewheight: NSLayoutConstraint!
    @IBOutlet weak var searchCategoryCollectionView: UICollectionView!
    let shared = mainViewModel.mainShared
    
    
    override func viewDidLoad() {
        
        initializeHideKeyboard()
        let loader = self.loader()

        searchCategoryCollectionView.delegate = self
        searchCategoryCollectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        topSearchView.isHidden = false
        
        noDataDisplayView.isHidden = true
        noDataDisplayViewheight.constant = 0
        
        super.viewDidLoad()
        shared.searchViewModelShared.getTopSearches { (result) in
            DispatchQueue.main.async {
                self.firstBtn.setTitle(self.shared.searchViewModelShared.topSearches[0], for: .normal)
                self.secondBtn.setTitle(self.shared.searchViewModelShared.topSearches[1], for: .normal)
                self.thirdBtn.setTitle(self.shared.searchViewModelShared.topSearches[2], for: .normal)
                self.fourthBtn.setTitle(self.shared.searchViewModelShared.topSearches[3], for: .normal)
                self.fifthBtn.setTitle(self.shared.searchViewModelShared.topSearches[4], for: .normal)
                
            }
        } fail: {  
            print("Top searches error")
        }
        
        searchTextField.delegate = self
        
        shared.categoriesViewModelShared.getCategories(token: shared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.searchCategoryCollectionView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
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
                            self.InitialDisplayView.isHidden = true
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayViewheight.constant = 0
                            self.categoriesViewHeight.constant = 0
                            self.tableView.isHidden = false
                            self.tableView.reloadData()

                            
                        }else {
                            self.tableView.isHidden = true
                            self.topSearchView.isHidden = true
                            self.InitialDisplayView.isHidden = false
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayView.isHidden = false
                            self.noDataDisplayViewheight.constant = 417
                            self.categoriesViewHeight.constant = 185
                            
                        }
                    }
                } fail: { (fail) in
                    print(fail)
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
        
        shared.searchViewModelShared.searchOption = searchTextField.text!
                shared.searchViewModelShared.getSearchResult { (result) in
                    DispatchQueue.main.async {
                        
                        if result.count != 0 {
                            
                            self.topSearchView.isHidden = true
                            self.noDataDisplayView.isHidden = true
                            self.CategoriesDisplayView.isHidden = true
                            self.InitialDisplayView.isHidden = true
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayViewheight.constant = 0
                            self.categoriesViewHeight.constant = 0
                            self.tableView.isHidden = false
                            self.tableView.reloadData()

                            
                        }else {
                            self.tableView.isHidden = true
                            self.topSearchView.isHidden = true
                            self.InitialDisplayView.isHidden = false
                            self.topSearchViewHeight.constant = 0
                            self.noDataDisplayView.isHidden = false
                            self.noDataDisplayViewheight.constant = 417
                            self.categoriesViewHeight.constant = 185
                            
                        }
                    }
                } fail: { (fail) in
                    print(fail)
                }
        
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
        cell.noOfChapters.text = String("\(shared.searchViewModelShared.searchResult[indexPath.row].noOfChapters) Chapters")
        let url = URL(string: shared.searchViewModelShared.searchResult[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        
        return cell
    }
    
}


extension SearchViewController: SearchResponse {
    func modallySearchResult() {
        self.topSearchView.isHidden = true
        self.noDataDisplayView.isHidden = true
        self.CategoriesDisplayView.isHidden = true
        self.InitialDisplayView.isHidden = true
        self.topSearchViewHeight.constant = 0
        self.noDataDisplayViewheight.constant = 0
        self.categoriesViewHeight.constant = 0
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func modallyNil() {
        self.tableView.isHidden = true
        self.topSearchView.isHidden = true
        self.InitialDisplayView.isHidden = false
        self.topSearchViewHeight.constant = 0
        self.noDataDisplayView.isHidden = false
        self.noDataDisplayViewheight.constant = 417
        self.categoriesViewHeight.constant = 185

    }
    
    
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shared.categoriesViewModelShared.listofCategories.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCategoryCollectionViewCell
        
        cell.categoryName.text = shared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
        
        let url = URL(string: shared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
        let data = try? Data(contentsOf: url!)
        
        cell.categoryImage.image = UIImage(data: data!)
        
        return cell
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
        
        vc.courseId = String(shared.searchViewModelShared.searchResult[indexPath.row].courseId)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryId = shared.homeViewModelShared.allCourse[indexPath.row].courseId
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchViewController {
    
    func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
       
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        
        view.endEditing(true)
    }
}
