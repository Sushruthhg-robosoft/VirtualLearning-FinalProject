//
//  TopCourseSectionCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 09/12/22.
//

import UIKit
protocol clickToplay{
    
    func playView(indexPath: IndexPath)
}

class TopCourseSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var courseImage: UIImageView!
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var chapterCount: UILabel!
    var index: IndexPath?
    var delegate: clickToplay?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickPlay(_ sender: Any) {
        if let indexpath = index{
            delegate?.playView(indexPath: indexpath)
        }
        
    }
}
