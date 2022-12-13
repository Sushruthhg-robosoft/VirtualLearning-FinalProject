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
    
    @IBOutlet weak var cellLeadingConstraint: NSLayoutConstraint!
    
  
    
}
