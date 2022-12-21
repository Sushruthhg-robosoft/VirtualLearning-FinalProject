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

    
    @IBOutlet weak var joinedView: UIView!
    
    @IBOutlet weak var joinedLeftView: UIView!
    @IBOutlet weak var joinedRightView: UIView!
    //make This constraint 0 while not displaying Course Content lable top constraint = 30
    
    @IBOutlet weak var overViewBtn: UIButton!
    @IBOutlet weak var overViewUnderLineView: UIView!
    @IBOutlet weak var chaptersUnderLineView: UIView!
    @IBOutlet weak var chaptersBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var CourseContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelconstraint: NSLayoutConstraint!
    @IBOutlet weak var ContinuationLabelHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var courseHeading: UILabel!
    @IBOutlet weak var courseCategory: customCourseCategoryLable!
    @IBOutlet weak var courseLessonAndChapters: UILabel!
    @IBOutlet weak var sourseContentDescription: UILabel!
    
    var delegate : switchVc?
    var dataoflesson = [LessonResponseList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinedLeftView.layer.cornerRadius = 5
        joinedRightView.layer.cornerRadius = 5
       
        joinedView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        joinedView.layer.shadowOpacity = 100
        joinedView.layer.shadowRadius = 5
        joinedView.layer.shadowOffset = CGSize(width: 0, height: 2)

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
        
//        shared.chaptersDetailsViewModelShared.getChapters(token: shared.token, courseId: "3") { result in
//            let loader = self.loader()
//            DispatchQueue.main.async { [self] in
//                let chapter = String(result.courseContentResponse.chapterCount) + "Chapter | "
//                let lesson = String(result.courseContentResponse.lessonCount) + "Lessons | "
//                let assesment = String(result.courseContentResponse.moduleTest) + "Assesment Test |"
//                let totalLength = String(result.courseContentResponse.totalVideoLength) + "h total Length"
//
//                self.sourseContentDescription.text = chapter + lesson + assesment + totalLength
//                self.dataoflesson = result.lessonResponseList
//                self.stopLoader(loader: loader)
//                tableView.reloadData()
//
//            }
//        } fail: {
//            print("failures")
//        }
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loader = self.loader()
        shared.chaptersDetailsViewModelShared.getChapters(token: shared.token, courseId: "3") { result in
            
            DispatchQueue.main.async { [self] in
                let chapter = String(result.courseContentResponse.chapterCount) + "Chapter | "
                let lesson = String(result.courseContentResponse.lessonCount) + "Lessons | "
                let assesment = String(result.courseContentResponse.moduleTest) + "Assesment Test |"
                let totalLength = String(result.courseContentResponse.totalVideoLength) + "h total Length"
               
                self.sourseContentDescription.text = chapter + lesson + assesment + totalLength
                self.dataoflesson = result.lessonResponseList
                self.stopLoader(loader: loader)
                tableView.reloadData()
         
            }
        } fail: {
            print("failures")
        }
    }
    
    @IBAction func onClickOverview(_ sender: Any) {
        

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
        

        if dataoflesson[section].isExpandable {
            return dataoflesson[section].lessonList.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! CustomChapterTableViewCell
   
        if let data = dataoflesson[indexPath.section].lessonList[indexPath.row] as? LessonList {
            
            cell.chapterName.text = data.lessonName
            cell.chapterNumber.text = "0\(String(data.lessonId))"
            cell.chapterDuration.text = "\(String(data.duration)) mins"
            cell.moduleTestView.isHidden = true
            cell.chapterNumberView.isHidden = false
            cell.chapterNumber.isHidden = false
            cell.progressViewWidthContraint.constant = 0
            cell.cellLeadingConstraint.constant = 0
            cell.progressHeight.constant = 0
            cell.progressWidth.constant = 0
        }
        
        if let data = dataoflesson[indexPath.section].lessonList[indexPath.row] as? AssignmentResponse {
            
            cell.moduleTestView.isHidden = false
            cell.chapterNumberView.isHidden = true
            cell.chapterNumber.isHidden = true
            cell.chapterName.text = data.assignmentName
            cell.chapterNumber.text = "0\(data.assignmentId ))"
            cell.chapterDuration.text = "\(data.testDuration )) mins"
            cell.progressViewWidthContraint.constant = 0
            cell.cellLeadingConstraint.constant = 0
            cell.progressHeight.constant = 0
            cell.progressWidth.constant = 0
        }
        
        
        
        
        
//        cell.chapterName.text = dataoflesson[indexPath.section].lessonList[indexPath.row].lessonName
//            cell.chapterNumber.text = "0\(String(dataoflesson[indexPath.section].lessonList[indexPath.row].lessonId))"
//            cell.chapterDuration.text = "\(String(dataoflesson[indexPath.section].lessonList[indexPath.row].duration)) mins"
//            cell.moduleTestView.isHidden = true
//            cell.progressViewWidthContraint.constant = 0
//            cell.cellLeadingConstraint.constant = 0
//            cell.progressHeight.constant = 0
//            cell.progressWidth.constant = 0
//
//         if dataoflesson[indexPath.section].assignmentResponse !=  nil{
//            print("Data inside assesments")
//            cell.moduleTestView.isHidden = false
//            cell.chapterNumberView.isHidden = true
//            cell.chapterNumber.isHidden = true
//            cell.chapterName.text = dataoflesson[indexPath.section].assignmentResponse?.assignmentName
//            cell.chapterNumber.text = "0\(String(dataoflesson[indexPath.section].assignmentResponse?.assignmentId ?? 0))"
//            cell.chapterDuration.text = "\(String(dataoflesson[indexPath.section].assignmentResponse?.testDuration ?? 0)) mins"
//            cell.moduleTestView.isHidden = true
//            cell.progressViewWidthContraint.constant = 0
//            cell.cellLeadingConstraint.constant = 0
//            cell.progressHeight.constant = 0
//            cell.progressWidth.constant = 0
//
//        }
//        let assignment = dataoflesson[indexPath.row].assignmentResponse?.assignmentName
//        print(14563212,assignment)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataoflesson.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.title.text = dataoflesson[section].chapterName
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
        dataoflesson[idx].isExpandable = !dataoflesson[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
    

}
