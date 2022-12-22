//
//  CatergoryCourseDisplayTableViewCell.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 15/12/22.
//

import UIKit

class CatergoryCourseDisplayTableViewCell: UITableViewCell {
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var totalNumberOfChapters: UILabel!
    @IBOutlet weak var categoryNAme: customCourseCategoryLable!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
