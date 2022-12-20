//
//  ExistingCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import UIKit

class ExistingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ongoingImage: UIImageView!
    @IBOutlet weak var ChapterName: UILabel!
    @IBOutlet weak var numberOfChapters: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickContinue(_ sender: Any) {
    }
}
