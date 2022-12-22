//
//  CustomChapterTableViewCell.swift
//  Chapters
//
//  Created by Manish R T on 12/12/22.
//

import UIKit

class CustomChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var moduleTestView: UIView!
    
    @IBOutlet weak var chapterNumberView: UIView!
    @IBOutlet weak var chapterNumber: UILabel!
    @IBOutlet weak var chapterName: UILabel!
    @IBOutlet weak var chapterDuration: UILabel!
    @IBOutlet weak var progressViewWidthContraint: NSLayoutConstraint!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    @IBOutlet weak var progressHeight: NSLayoutConstraint!
    @IBOutlet weak var videoPlayButton: UIButton!
    @IBOutlet weak var timelineIndicatorImage: UIImageView!
    
    @IBOutlet weak var cellLeadingConstraint: NSLayoutConstraint!
    
  
    func setValuesLesson(data: LessonList) {
        chapterName.text = data.lessonName
        chapterNumber.text = "0\(String(data.lessonId))"
        chapterDuration.text = "\(String(data.duration)) mins"
        moduleTestView.isHidden = true
        chapterNumberView.isHidden = false
        chapterNumber.isHidden = false
        progressStatus(data: data)
        
    }
    
    func setValuesAssignment(data: AssignmentResponse) {
        moduleTestView.isHidden = false
        chapterNumberView.isHidden = true
        chapterNumber.isHidden = true
        chapterName.text = data.assignmentName
        chapterNumber.text = "0\(data.assignmentId ))"
        chapterDuration.text = "\(data.testDuration )) mins"
        videoPlayButton.isHidden = true
        
    }
    
    func cellconstrints(joinedCourse: Bool) {
        if(joinedCourse) {
            cellLeadingConstraint.constant = 13
            progressViewWidthContraint.constant = 20
            progressHeight.constant = 20
            progressWidth.constant = 20
        }
        else {
            cellLeadingConstraint.constant = 0
            progressViewWidthContraint.constant = 0
            progressHeight.constant = 0
            progressWidth.constant = 0
        }
    }
    func progressStatus(data: LessonList) {
        if(data.lessonCompleted) {
            
            videoPlayButton.setImage(#imageLiteral(resourceName: "icn_lessonplay_active"), for: .normal)
            timelineIndicatorImage.image = #imageLiteral(resourceName: "icn_textfield_right")
            
        } else {
            if(data.nextPlay)  {
                videoPlayButton.setImage(#imageLiteral(resourceName: "icn_lessonplay_active"), for: .normal)
                timelineIndicatorImage.image = #imageLiteral(resourceName: "icn_timeline_active")
                
            } else {
                videoPlayButton.setImage(#imageLiteral(resourceName: "icn_lessonplay_inactive"), for: .normal)
                timelineIndicatorImage.image = #imageLiteral(resourceName: "icn_timeline_inactive")
                
            }
        }
    }
    
    func assesmentProgress() {
        
        
    }
    
}
