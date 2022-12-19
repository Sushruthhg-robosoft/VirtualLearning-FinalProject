//
//  TopCourseSectionCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 09/12/22.
//

import UIKit

class TopCourseSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var courseImage: UIImageView!
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var chapterCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
