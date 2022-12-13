//
//  ChaptersViewController.swift
//  Chapters
//
//  Created by Manish R T on 12/12/22.
//

import UIKit

class ChaptersViewController: UIViewController {

    
    
    //make This constraint 0 while not displaying Course Content lable top constraint = 30
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var CourseContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelconstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelHeightContraint: NSLayoutConstraint!
    
    var data = [Chapter(chapterName: "Chapter 1 - Introduction to the course", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 2 - Learning the Figma Interface", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 3 - Setting up a new project", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 4 - Adding and Editing Content", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 5 - Completing the Design", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ContinuationLabelHeightContraint.constant = 0
        ContinuationLabelconstraint.constant = 0
        CourseContentConstraint.constant = 0
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func onClickOverview(_ sender: Any) {
//        
//        let vc = storyboard?.instantiateViewController(identifier: "CourseDetailsViewController") as! CourseDetailsViewController
//        
//        vc.chaptersContainerView.isHidden = true
//        vc.CourseoverviewView.isHidden = false
    }
    

}

extension ChaptersViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if data[section].isExpandable {
            return data[section].lessonNames.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! CustomChapterTableViewCell
        cell.chapterName.text = data[indexPath.section].lessonNames[indexPath.row]
        cell.moduleTestView.isHidden = true
        cell.progressViewWidthContraint.constant = 0
        cell.cellLeadingConstraint.constant = 0
        cell.progressHeight.constant = 0
        cell.progressWidth.constant = 0
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.title.text = data[section].chapterName
        headerView.button.setImage(#imageLiteral(resourceName: "icn_chapter maximise"), for: .normal)
        headerView.delegateForHeader = self
        headerView.secIndex = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
}

extension ChaptersViewController: headerDelegate{
    func callHeader(idx: Int) {
        data[idx].isExpandable = !data[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
    
    
}
