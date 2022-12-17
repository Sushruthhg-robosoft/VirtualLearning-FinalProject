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
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.searchView.setBorder()
        self.searchTextField.removeBorder()
        super.viewDidLoad()
        let loader = self.loader()
        mainShared.homeViewModelShared.getAllCourseDeatils { (data) in
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.tableView.reloadData()
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
        return mainShared.homeViewModelShared.allCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseYourCourseTableViewCell
        cell.couseName.text = mainShared.homeViewModelShared.allCourse[indexPath.row].courseName
        cell.courseCategory.text = mainShared.homeViewModelShared.allCourse[indexPath.row].categoryName
        cell.numberofChapters.text = "\(mainShared.homeViewModelShared.allCourse[indexPath.row].totalNumberOfChapters) chapters"
        let url = URL(string: mainShared.homeViewModelShared.allCourse[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        return cell
    }
    
    
    
}


