//
//  ChaptersViewController.swift
//  Chapters
//
//  Created by Manish R T on 12/12/22.
//

import UIKit

protocol switchVc{
    
    func switchVc()
}

class ChaptersViewController: UIViewController {

    var shared = mainViewModel.mainShared

    
    //make This constraint 0 while not displaying Course Content lable top constraint = 30
    
    @IBOutlet weak var overViewBtn: UIButton!
    @IBOutlet weak var overViewUnderLineView: UIView!
    @IBOutlet weak var chaptersUnderLineView: UIView!
    @IBOutlet weak var chaptersBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var CourseContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelconstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelHeightContraint: NSLayoutConstraint!
    
    var delegate : switchVc?
    var data = [Chapter(chapterName: "Chapter 1 - Introduction to the course", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 2 - Learning the Figma Interface", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 3 - Setting up a new project", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 4 - Adding and Editing Content", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false),Chapter(chapterName: "Chapter 5 - Completing the Design", lessonNames: ["Introduction", "Using the Exercise Files"], isExpandable: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ContinuationLabelHeightContraint.constant = 0
        ContinuationLabelconstraint.constant = 0
        CourseContentConstraint.constant = 0
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.delegate = self
        tableView.dataSource = self
        chaptersBtn.setTitleColor(#colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1), for: .normal)
        chaptersUnderLineView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
        overViewBtn.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
        overViewUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        
        shared.chaptersDetailsViewModelShared.getChapters(courseId: "3") { result in
            print(result)
        } fail: {
            print("failures")
        }
 
    }
    
    @IBAction func onClickOverview(_ sender: Any) {
        
//        overViewBtn.setTitleColor(#colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1), for: .normal)
//        overViewUnderLineView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
//        chaptersBtn.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
//        chaptersUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        delegate?.switchVc()

        
    }
    
    @IBAction func onClickChapter(_ sender: Any) {
        
        
    }
    
    
    @IBAction func onClickClose(_ sender: Any) {
       
        navigationController?.popViewController(animated: true)
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
