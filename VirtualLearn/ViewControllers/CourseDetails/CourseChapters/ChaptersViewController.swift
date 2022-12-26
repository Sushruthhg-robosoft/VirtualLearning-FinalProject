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

    
    @IBOutlet weak var courseImage: UIImageView!
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
    @IBOutlet weak var joinCourseButton: UIButton!
    
    @IBOutlet weak var contunuationLabel: UILabel!
    @IBOutlet weak var certficateView: UIView!
    @IBOutlet weak var certificateViewHeight: NSLayoutConstraint!
    @IBOutlet weak var certificateGrade: UILabel!
    @IBOutlet weak var joinedDate: UILabel!
    @IBOutlet weak var completedDate: UILabel!
    @IBOutlet weak var totalDuration: UILabel!
    @IBOutlet weak var certificateImage: UIImageView!
    
    @IBOutlet weak var popUpLabel: UILabel!
    @IBOutlet weak var popUpFrontView: UIView!
    @IBOutlet weak var popUpBackView: UIView!
    var delegate : switchVc?
    var courseId = ""
    var lessonId = ""
    var dataoflesson = [LessonResponseList]()
    var imageUrl = ""
    var storageShared = StorageManeger.shared
    var url = ""
    var time = 12

    override func viewDidLoad() {
        
        shared.courseDetailsViewModelShared.courseOverView(token: shared.token, courseId: courseId) { courseDataOverView in
            
            DispatchQueue.main.async {
                let url1 = URL(string: courseDataOverView.courseHeader.courseImage)
                guard let data1 = try? Data(contentsOf: url1!) else {return}
                self.courseImage.image = UIImage(data: (data1))
                
                self.courseHeading.text = courseDataOverView.courseHeader.courseName
                self.courseCategory.text = courseDataOverView.courseHeader.categoryName
                self.courseLessonAndChapters.text = String( courseDataOverView.courseHeader.totalNumberOfChapters)+" Chapters | " + String( courseDataOverView.courseHeader.totalNumberOfChapters)+" Lessons"
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
        
        popUpBackView.isHidden = true
        super.viewDidLoad()
        print("123456789", courseId)
//        dataLoading()
        joinedLeftView.layer.cornerRadius = 5
        joinedRightView.layer.cornerRadius = 5
       
        joinedView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        joinedView.layer.shadowOpacity = 100
        joinedView.layer.shadowRadius = 5
        joinedView.layer.shadowOffset = CGSize(width: 0, height: 2)
        dataLoading()
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
 
    }
//    override func viewDidAppear(_ animated: Bool) {
//        dataLoading()
//    }
    
    @IBAction func onClickContinueWatching(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "VideoPlayViewController") as? VideoPlayViewController
        vc?.url = url
        vc?.seconds = time
        vc?.delegate = self
        self.popUpBackView.isHidden = true
        if let viewController = vc{
            navigationController?.pushViewController(viewController, animated: true)
        
        }
    
    }
    @IBAction func onClickWatchFromBeginning(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "VideoPlayViewController") as? VideoPlayViewController
        vc?.seconds = 0
        vc?.url = url
        vc?.delegate = self
        self.popUpBackView.isHidden = true
        if let viewController = vc{
            navigationController?.pushViewController(viewController, animated: true)
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
    
    @IBAction func joinCourseClicked(_ sender: Any) {
        if storageShared.isLoggedIn() {
            shared.courseDetailsViewModelShared.joinCourse(token: shared.token, courseId: courseId){ data in
                DispatchQueue.main.async { [self] in
                    joinCourseButton.isHidden = true
                    dataLoading()
                }
                
            }fail: { error in
                print("failures")
                DispatchQueue.main.async {
                    if(error == "unauthorized") {
                        self.storageShared.resetLoggedIn()
                        self.okAlertMessagePopupforLoginforExsistingUser(message: "Your session is Expired")
                        
                    }
                    else {
                        self.okAlertMessagePopup(message: "Failed to join course")
                    }
                }
            }
        } else
        {
            self.okAlertLogin(message: "pleaseLogin")
        }
    }
    
    
    @IBAction func onClickDownload(_ sender: Any) {
        shared.chaptersDetailsViewModelShared.downloadCertificate(imageUrl: imageUrl )
    }
    
    func dataLoading() {
        let loader = self.loader()
        popUpBackView.isHidden = true
       
        print("view did appear ")
        shared.chaptersDetailsViewModelShared.getChapters(token: shared.token, courseId: courseId) { result in
           
            DispatchQueue.main.async { [self] in
                if(result.joinedCourse) {
                    self.joinCourseButton.isHidden = true
                }
                else {
                    self.joinCourseButton.isHidden = false
                }
                
                let chapter = String(result.courseContentResponse.chapterCount) + "Chapter | "
                let lesson = String(result.courseContentResponse.lessonCount) + "Lessons | "
                let assesment = String(result.courseContentResponse.moduleTest) + "Assesment Test |"
                let totalLength = String(result.courseContentResponse.totalVideoLength) + "h total Length"
               
                self.sourseContentDescription.text = chapter + lesson + assesment + totalLength
                dataoflesson.removeAll()
                self.dataoflesson = result.lessonResponseList
                
                self.stopLoader(loader: loader)
                if(result.certificateGenerated) {
                    self.certficateView.isHidden = false
                    certificateViewHeight.constant = 556
                    
                    self.certificateGrade.text = String(result.certificateResponse?.grade ?? 0) + "%"
                    self.joinedDate.text = result.certificateResponse?.joinedData
                    self.completedDate.text = result.certificateResponse?.completedDate
                    self.totalDuration.text = result.certificateResponse?.completionDuration
                    self.imageUrl = result.certificateResponse?.certificateLink ?? ""
                    tableView.reloadData()
                    guard let url = URL(string: result.certificateResponse?.certificateLink ?? "") else {return}
                    guard let data = try? Data(contentsOf: url) else {return}
                    self.certificateImage.image = UIImage(data: data)
                }
                else
                {
                self.certficateView.isHidden = true
                certificateViewHeight.constant = 0
                }
                tableView.reloadData()
            }
        } fail: { error in
            
            self.stopLoader(loader: loader)
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
            cell.cellconstrints(joinedCourse: self.joinCourseButton.isHidden)
            cell.setValuesLesson(data: data)
        }
        
        if let data = dataoflesson[indexPath.section].lessonList[indexPath.row] as? AssignmentResponse {
            
            cell.setValuesAssignment(data: data)
        }
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataoflesson.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.title.text = "Chapter \(dataoflesson[section].chapterNumber) - \(dataoflesson[section].chapterName)"
        if(dataoflesson[section].chapterCompleted) {
            headerView.title.textColor = UIColor(red: 30/255, green: 171/255, blue: 12/255, alpha: 1)
        }
        else {
            headerView.title.textColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        }
        if(dataoflesson[section].isExpandable) {
            headerView.button.setImage(#imageLiteral(resourceName: "icn_chapter minimise"), for: .normal)
        }
        else {
            headerView.button.setImage(#imageLiteral(resourceName: "icn_chapter maximise"), for: .normal)
        }
        
        headerView.delegateForHeader = self
        headerView.secIndex = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let data = dataoflesson[indexPath.section].lessonList[indexPath.row] as? AssignmentResponse {
            if(data.assinmentStatus) {
               guard let vc = storyboard?.instantiateViewController(identifier: "TestResultViewController") as? TestResultViewController else {return}
               navigationController?.pushViewController(vc, animated: true)
            }else if (data.nextPlay) {
                guard let vc = storyboard?.instantiateViewController(identifier: "ModuleTestViewController") as? ModuleTestViewController else{return}
                navigationController?.pushViewController(vc, animated: true)
                vc.assignmentId = String(data.assignmentId)
            } else if(!data.assinmentStatus) {
                self.okAlertMessagePopup(message: "please complete previous all Chapters")
            }
        }
    }
}
extension ChaptersViewController : PauseVideoStatus {
    func sendTime(second: Int) {
        let loader = self.loader()
        print("sdfghj",second)
        self.time = second
        shared.chaptersDetailsViewModelShared.saveLesson(lessonId: lessonId, duration: String(second), token: shared.token) {
            self.stopLoader(loader: loader)
            print("saved Successfully")
            DispatchQueue.main.async {
                self.dataLoading()
            }
        } fail: { error in
            print("error to load data")
        }
        
        
    }
}

extension ChaptersViewController: headerDelegate{
    func callHeader(idx: Int) {
        dataoflesson[idx].isExpandable = !dataoflesson[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
    

}


extension ChaptersViewController: playVideo{
    func playVideo(at index: IndexPath) {
        
        if let data = dataoflesson[index.section].lessonList[index.row] as? LessonList{
            if(data.lessonCompleted || data.nextPlay) {
            lessonId = String(data.lessonId)
                if (data.durationCompleted > 0 && ((data.durationCompleted)+3 < data.duration )){
                
                self.popUpBackView.isHidden = false
                popUpLabel.text = "Your lesson paused at \(data.durationCompleted) secs Do you want to continue watching?"
                time = data.durationCompleted
                url = data.videoLink
            }
            else{
                let vc = storyboard?.instantiateViewController(identifier: "VideoPlayViewController") as? VideoPlayViewController
                vc?.delegate = self
                self.popUpBackView.isHidden = true
                vc?.url = data.videoLink
                vc?.seconds = 0
                vc?.heading = "Chapter \(data.lessonNumber) - \(data.lessonName)"
                if let viewController = vc{
                    navigationController?.pushViewController(viewController, animated: true)
                }

            }
            
            } else if(!data.lessonCompleted) {
                self.okAlertMessagePopup(message: "please complete previous Videos")
            }
           
        }
    }
    
    func okAlertLogin(message: String){
        
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
            
            let vc = self.storyboard?.instantiateViewController(identifier: "LoginPageViewController") as? LoginPageViewController
            vc?.isPresented = true
            self.navigationController?.popToRootViewController(animated: true)
         })
        dialogMessage.addAction(ok)

        self.present(dialogMessage, animated: true, completion: nil)
        
    }

}
