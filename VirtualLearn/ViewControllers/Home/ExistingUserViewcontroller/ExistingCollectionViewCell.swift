//
//  ExistingCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import UIKit

protocol CourseContinue {
    func continueCourse(indexPath: IndexPath)
}

class ExistingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ongoingImage: UIImageView!
    @IBOutlet weak var ChapterName: UILabel!
    @IBOutlet weak var numberOfChapters: UILabel!
    var mainShared = mainViewModel.mainShared
    var shared = ViewModel.shared
    var delegate : CourseContinue?
    var Index : IndexPath? 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickContinue(_ sender: Any) {
        
        print("button tapped for continue")
        guard let index = Index else{return}
        delegate?.continueCourse(indexPath: index)
    }
}
