//
//  ViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class MyCourseViewController: UIViewController {
    
    

    @IBOutlet weak var ongoingBtn: UIButton!
    
    @IBOutlet weak var completedBtn: UIButton!
    
    @IBOutlet weak var newUserContainerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var existingUserView: UIView!
    @IBOutlet weak var newUserView: UIView!
    
    var isOngoing: Bool = true
    var isCompleted: Bool = false
    var shared = mainViewModel.mainShared
    var isNewUser: Bool = false
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        newUserContainerView.isHidden = true
        super.viewDidLoad()
        


        
        
        
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loder = self.loader()
        shared.myCourseViewModelShared.getMycourseDetails {
            
            DispatchQueue.main.async { [self] in
                self.stopLoader(loader: loder)
                self.tableView.reloadData()
                if shared.myCourseViewModelShared.ongoingCourses.count == 0{
                    
                    existingUserView.isHidden = true
                    newUserView.isHidden = false
                    view.bringSubviewToFront(newUserView)
                }
                else{
                    
                    existingUserView.isHidden = false
                    newUserView.isHidden = true
                    view.bringSubviewToFront(existingUserView)
                }
            }
        } fail: {
            print("fail")
        }
    }

    
    @IBAction func onClickOngoingBtn(_ sender: Any) {
        completedBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        completedBtn.setTitleColor(#colorLiteral(red: 0.5518978834, green: 0.5519112945, blue: 0.5519040227, alpha: 1), for: .normal)
        ongoingBtn.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        ongoingBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        isOngoing = true
        isCompleted = false
        tableView.reloadData()
    }
    
    @IBAction func onClickCompletedBtn(_ sender: Any) {
        
       
        
        completedBtn.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        completedBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        ongoingBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ongoingBtn.setTitleColor(#colorLiteral(red: 0.5518978834, green: 0.5519112945, blue: 0.5519040227, alpha: 1), for: .normal)
        isOngoing = false
        isCompleted = false
        tableView.reloadData()
    }
    
    @IBAction func onClickBurger(_ sender: Any) {
        
        
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        
    }
    
    
    
    
}

extension MyCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isOngoing{
            return shared.myCourseViewModelShared.ongoingCourses.count
        }
        else{
            return shared.myCourseViewModelShared.completedCourses.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCourseTableViewCell
        
        if isOngoing{
            cell.courseName.text = shared.myCourseViewModelShared.ongoingCourses[indexPath.row].courseName
            let url = URL(string: shared.myCourseViewModelShared.ongoingCourses[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.courseImage.image = UIImage(data: data!)
            cell.myCouseStatus.text = "Ongoing"
            cell.chapters.text = "\(shared.myCourseViewModelShared.ongoingCourses[indexPath.row].completedCount)/\(shared.myCourseViewModelShared.ongoingCourses[indexPath.row].totalNumberOfChapters)"
            
        }
        else{
            cell.courseName.text = shared.myCourseViewModelShared.completedCourses[indexPath.row].courseName
            let url = URL(string: shared.myCourseViewModelShared.completedCourses[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.courseImage.image = UIImage(data: data!)
            cell.myCouseStatus.text = "Completed"
            cell.chapters.text = "\(shared.myCourseViewModelShared.ongoingCourses[indexPath.row].completedCount)/\(shared.myCourseViewModelShared.completedCourses[indexPath.row].totalNumberOfChapters)"
            cell.button.setTitle("View Certificate", for: .normal)
        }
        
        return cell
    }
    
    
}

