//
//  MyCourseTableViewCell.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit
protocol gotoVideoOrCertificate{
    func doVc(index: IndexPath, courseId: String)
}

class MyCourseTableViewCell: UITableViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    
    @IBOutlet weak var myCouseStatus: UILabel!
    
    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var chapters: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var delegate: gotoVideoOrCertificate?
    var index: IndexPath?
    var courseId: String?
    @IBOutlet weak var onClickContinueOrCertificate: UIButton!
    @IBAction func onClickNext(_ sender: Any) {
        
        delegate?.doVc(index: index!, courseId: courseId!)
    }
}
