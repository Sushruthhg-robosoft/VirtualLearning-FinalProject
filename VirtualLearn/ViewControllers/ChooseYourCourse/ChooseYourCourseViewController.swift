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
    var mainShared = mainViewModel.mainShared
    var tableData = [HomeCourse]()
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
     
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.searchView.setBorder()
        self.searchTextField.removeBorder()
        super.viewDidLoad()
        let loader = self.loader()
        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.tableView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
        mainShared.categoriesViewModelShared.getCategories(token: mainShared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.categoriesCollectionView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
        }




    }
    
    @IBAction func onclickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension ChooseYourCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseYourCourseTableViewCell
        cell.couseName.text = tableData[indexPath.row].courseName
        cell.courseCategory.text = tableData[indexPath.row].categoryName
        cell.numberofChapters.text = "\(tableData[indexPath.row].totalNumberOfChapters) chapters"
        let url = URL(string: tableData[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        return cell
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
    
    func allCourse(){
        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
            
        } fail: { error in 
            print("fail")
        }
    }
    
    
    func newestCourse(){
        mainShared.homeViewModelShared.getNewestCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
        } fail: {error in
            print("fail")
        }
    }
    
    func popularCourse(){
        mainShared.homeViewModelShared.getPopularCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.tableData = data
                self.tableView.reloadData()
            }
        } fail: {error in
            print("fail")
        }
    }
}


