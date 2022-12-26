//
//  ChooseYourCourseViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class ChooseYourCourseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: customChooseCourseView!
    @IBOutlet weak var searchTextField: UITextField!
    var mainShared = mainViewModel.mainShared
    var tableData = [HomeCourse]()
    var isSearch = false
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        initializeHideKeyboard()
        searchTextField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.searchView.setBorder()
        self.searchTextField.removeBorder()
        super.viewDidLoad()
        let loader = self.loader()

        
        mainShared.categoriesViewModelShared.getCategories(token: mainShared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.categoriesCollectionView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
        }
        
        
        self.tableView.reloadData()
        
    }

    
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        mainShared.searchViewModelShared.searchOption = searchTextField.text!
                mainShared.searchViewModelShared.getSearchResult { (result) in
                    DispatchQueue.main.async {
                        
                        if result.count != 0 {
                            self.isSearch = true
                            self.tableView.reloadData()

                            
                        }else {
                            self.isSearch = false
                            self.tableView.reloadData()
                        }
                    }
                } fail: { (fail) in
                    print(fail)
                }
        
        return true
    }
    
    
    @IBAction func onclickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickFilter(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ModallyViewController") as? ModallyViewController
        
        present(vc!, animated: true, completion: nil)
        
        vc?.searchField = searchTextField.text!
        vc?.delegate = self
        
    }
    
}

extension ChooseYourCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch{
            return mainShared.searchViewModelShared.searchResult.count
        }else{
            
            return self.tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseYourCourseTableViewCell
        if self.isSearch == true {
                
            cell.couseName.text = self.mainShared.searchViewModelShared.searchResult[indexPath.row].courseName
                cell.courseCategory.text = self.mainShared.searchViewModelShared.searchResult[indexPath.row].categoryName
                cell.numberofChapters.text = String(self.mainShared.searchViewModelShared.searchResult[indexPath.row].noOfChapters)
                let url = URL(string: self.mainShared.searchViewModelShared.searchResult[indexPath.row].courseImage)
                            let data = try? Data(contentsOf: url!)
                            cell.courseImage.image = UIImage(data: data!)
                       
            return cell
        }else{
        cell.couseName.text = tableData[indexPath.row].courseName
        cell.courseCategory.text = tableData[indexPath.row].categoryName
        cell.numberofChapters.text = "\(tableData[indexPath.row].totalNumberOfChapters) chapters"
        cell.selectionStyle = .none
        let url = URL(string: tableData[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
        vc.courseId = mainShared.homeViewModelShared.allCourse[indexPath.row].courseId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
extension ChooseYourCourseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainShared.categoriesViewModelShared.listofCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseYourCourseCollectionViewCell
        
        cell.categoryName.text = mainShared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
        
        let url = URL(string: mainShared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
        let data = try? Data(contentsOf: url!)
        
        cell.categoryImage.image = UIImage(data: data!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryId = mainShared.categoriesViewModelShared.listofCategories[indexPath.row].categoryId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func allCourse(){
        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
            
        } fail: { error in 
            print("getAllCourseDeatils fail")
        }
    }
    
    
    func newestCourse(){
        mainShared.homeViewModelShared.getNewestCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
        } fail: {error in
            print("getNewestCourseDetails fail")
        }
    }
    
    func popularCourse(){
        mainShared.homeViewModelShared.getPopularCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
        } fail: {error in
            print("getPopularCourseDetails fail")
        }
    }
}


extension ChooseYourCourseViewController: SearchResponse {
    func modallySearchResult() {
        self.isSearch = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func modallyNil() {
        self.tableView.isHidden = true
        

    }
    
    
}

extension ChooseYourCourseViewController {
    
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

