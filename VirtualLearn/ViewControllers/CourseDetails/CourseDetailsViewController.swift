//
//  CourseDetailsViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 12/12/22.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
    var shared = mainViewModel.mainShared
    
    
    @IBOutlet weak var tableView3Height: NSLayoutConstraint! //128
    @IBOutlet weak var tableView1Height: NSLayoutConstraint! //210
    @IBOutlet weak var tableView2Height: NSLayoutConstraint! //178
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
    
    @IBOutlet weak var CourseOverViewView: UIView!
    
    @IBOutlet weak var CourseChapterView: UIView!
    
    @IBOutlet weak var courseDescriptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var overViewScrollView: UIScrollView!
    
    @IBOutlet weak var joinCourseButton: UIButton!
    var chapterVc: ChaptersViewController?
    var storageManager = StorageManeger.shared
    var courseOverView: CourseOverview? = nil
    var courseIncludes = [String]()
    var courseOutcome = [String]()
    var courseRequirment = [String]()
    var courseId = ""
    var hideJoinCourse = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView3.delegate = self
        tableView3.dataSource = self
        
        CourseOverViewView.isHidden = false
        CourseChapterView.isHidden = true
        overViewBtn.setTitleColor(#colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1), for: .normal)
        overViewUnderLineView.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
        chaptersBtn.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
        chaptersUnderLineView.backgroundColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
        
        
        
        shared.courseDetailsViewModelShared.courseOverView(token: shared.token, courseId: courseId) { courseDataOverView in
            self.courseOverView = courseDataOverView
            DispatchQueue.main.async { [self] in
                if(courseDataOverView.joinedCourse) {
                    joinCourseButton.isHidden = true
                    self.hideJoinCourse = true
                }
                else {
                    joinCourseButton.isHidden = false
                    self.hideJoinCourse = false
                }
                let url1 = URL(string: courseDataOverView.courseHeader.courseImage)
                guard let data1 = try? Data(contentsOf: url1!) else {return}
                self.courseImage.image = UIImage(data: (data1))
                
                self.CourseHeading.text = courseDataOverView.courseHeader.courseName
                self.courseType.text = courseDataOverView.courseHeader.categoryName
                self.courseChapters.text = String( courseDataOverView.courseHeader.totalNumberOfChapters)+" Chapters | " + String( courseDataOverView.courseHeader.totalNumberOfChapters)+" Lessons"
                
                self.courseIncludes.append(convertsectomins(seconds: courseDataOverView.courseIncludes.totalVideoContent) + " total hours video")
                if(courseDataOverView.courseIncludes.supportedFiles) {
                    self.courseIncludes.append("Supports Files")
                }
                self.courseIncludes.append(String(courseDataOverView.courseIncludes.moduleTest) + " Module Test")
                if(courseDataOverView.courseIncludes.fullLifeTimeAccess) {
                    self.courseIncludes.append("Full lifetime access")
                }
                self.courseIncludes.append(courseDataOverView.courseIncludes.acessOn)
                if(courseDataOverView.courseIncludes.CertificationofCompletion) {
                    self.courseIncludes.append("Certificate of Completion")
                }
                self.courseCaption.text = courseDataOverView.overView.courseDescription
                
                
                self.courseDescription.sizeToFit()
                self.courseDescription.text = courseDataOverView.overView.previewCourseContent
                
            
                self.courseOutcome = courseDataOverView.overView.courseOutCome

                if courseOutcome.count == 0{
                    self.tableView2Height.constant = 0
                } else {
                    self.tableView2Height.constant = 178
                }
                
                self.courseRequirment = courseDataOverView.overView.requirments
                if courseRequirment.count == 0 {
                    self.tableView3Height.constant = 0
                } else {
                    
                    self.tableView3Height.constant = 128

                }
                

                self.instructorName.text = courseDataOverView.Instructor.instructorName
                self.instructorOccupation.text = courseDataOverView.Instructor.occupation
                self.instructorDescription.text = courseDataOverView.Instructor.about
                
                let url = URL(string: courseDataOverView.Instructor.profilePic)
                let data = try? Data(contentsOf: url!)
                self.instructorImage.image = UIImage(data: data!)
                tableView1.reloadData()
                tableView2.reloadData()
                tableView3.reloadData()
                
            }
            
        } fail: { error in
            
            print("failures")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        
       
        
    }
    func convertsectomins(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let second = (seconds % 3600) % 60
        let minsAndSecond = String(hours) + ":" + String(minutes) + ":" + String(second)
        return minsAndSecond
    }
    
    
    @IBAction func onClickOverView(_ sender: Any) {
        
        
        CourseChapterView.isHidden = true
        CourseOverViewView.isHidden = false
        view.bringSubviewToFront(CourseOverViewView)
        
    }
    
    
    @IBAction func onClickChapters(_ sender: Any) {
        
        
        
        CourseChapterView.isHidden = false
        CourseOverViewView.isHidden = true
        overViewScrollView.isScrollEnabled = false
        view.bringSubviewToFront(CourseChapterView)
        
        
        
    }
    
    @IBAction func onClickPreview(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "VideoPlayViewController") as? VideoPlayViewController else{return}
        
        
        let url = courseOverView?.overView.videoLink
        
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func onClickCancel(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickJoinCourse(_ sender: Any) {
        
        if storageManager.isLoggedIn() {
            shared.courseDetailsViewModelShared.joinCourse(token: shared.token, courseId: courseId){ data in
                DispatchQueue.main.async { [self] in
                    CourseChapterView.isHidden = false
                    joinCourseButton.isHidden = true
                    CourseOverViewView.isHidden = true
                    overViewScrollView.isScrollEnabled = false
                    overViewScrollView.setContentOffset(.zero, animated: true)
                    chapterVc?.dataLoading()
                    view.bringSubviewToFront(CourseChapterView)
                    
                }
                
            }fail: { error in
                print("failures")
                DispatchQueue.main.async {
                    if(error == "unauthorized") {
                        self.storageManager.resetLoggedIn()
                        self.okAlertMessagePopupforLoginforExsistingUser(message: "Your session is Expired")
                        
                    }
                    else {
                        self.okAlertMessagePopup(message: "Failed to join course")
                    }
                }
            }
        } else
        {
            self.okAlertMessagePopupforLogin(message: "Please Login")
        }
        
    }
    
    func switchview(){
        CourseChapterView.isHidden = false
        CourseOverViewView.isHidden = true
        overViewScrollView.isScrollEnabled = false
        view.bringSubviewToFront(CourseChapterView)
    }
    
    
}

extension CourseDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView{
        case tableView1:
            return courseIncludes.count
        case tableView2:
            return courseOutcome.count
        case tableView3:
            return courseRequirment.count
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tableView1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CourseDetailseTableViewCell
            cell.courseIncludesLabel.text = courseIncludes[indexPath.row]
            return cell
        case tableView2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! CourseDetailseTableViewCell
            cell.WhatYouLearnLabel.text  = courseOutcome[indexPath.row]
            return cell
            
        case tableView3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! CourseDetailseTableViewCell
            cell.courseIncludesLabel.text  = courseRequirment[indexPath.row]
            return cell
            
        default:
            
            return UITableViewCell()
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "switch" {
            guard let vc = segue.destination as? ChaptersViewController else { return }
            chapterVc = vc
            vc.delegate = self
            vc.courseId = courseId
            vc.joinedCourse = self.hideJoinCourse
            if(joinCourseButton.isHidden) {
                vc.joinCourseButton.isHidden = true
            }
        }
    }
}

extension CourseDetailsViewController: switchVc{
    func switchVc() {
        CourseChapterView.isHidden = true
        CourseOverViewView.isHidden = false
        overViewScrollView.isScrollEnabled = true
        view.bringSubviewToFront(CourseOverViewView)
    }
    
    
    
}

extension CourseDetailsViewController: UITextViewDelegate{
    
    func adjustUITextViewHeight(arg : UITextView) {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
}
