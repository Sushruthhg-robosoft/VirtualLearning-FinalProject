//
//  CourseDetailsViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 12/12/22.
//

import UIKit

class CourseDetailsViewController: UIViewController {

    @IBOutlet weak var CourseHeading: UILabel!
    @IBOutlet weak var courseType: UILabel!
    @IBOutlet weak var courseChapters: UILabel!
    @IBOutlet weak var overViewBtn: UIButton!
    @IBOutlet weak var overViewUnderLineView: UIView!
    @IBOutlet weak var chaptersUnderLineView: UIView!
    @IBOutlet weak var chaptersBtn: UIButton!
    @IBOutlet weak var tableView1: UITableView!
    
    @IBOutlet weak var tableView3: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var courseCaption: UILabel!
    @IBOutlet weak var introductionDuration: UILabel!
    
    @IBOutlet weak var courseDescription: UITextView!
    @IBOutlet weak var instructorImage: UIImageView!
    
    @IBOutlet weak var instructorName: UILabel!
    
    @IBOutlet weak var instructorOccupation: UILabel!
    
    @IBOutlet weak var instructorDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView3.delegate = self
        tableView3.dataSource = self
      
    }
    
    @IBAction func onClickOverView(_ sender: Any) {
        
        overViewBtn.setTitleColor(#colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1), for: .normal)
        overViewUnderLineView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
        chaptersBtn.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
        chaptersUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        
        
    }
    
    
    @IBAction func onClickChapters(_ sender: Any) {
        
        chaptersBtn.setTitleColor(#colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1), for: .normal)
        chaptersUnderLineView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
        overViewBtn.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
        overViewUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        
        
    }
    
    @IBAction func onClickPreview(_ sender: Any) {
        
    }
    
    
    
    @IBAction func onClickJoinCourse(_ sender: Any) {
    }
    

}

extension CourseDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView{
        case tableView1:
            return 6
        case tableView2:
            return 4
        case tableView3:
        return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tableView1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CourseDetailseTableViewCell
                    
                    return cell
        case tableView2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! CourseDetailseTableViewCell
                    
                    return cell
            
        case tableView3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! CourseDetailseTableViewCell
                    
                    return cell
            
        default:
            
            return UITableViewCell()
        }
        
    }
}