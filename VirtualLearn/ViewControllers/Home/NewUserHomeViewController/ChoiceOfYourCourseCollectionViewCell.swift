//
//  ChoiceOfYourCourseCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit

class ChoiceOfYourCourseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var numberOfChapters: UILabel!
    @IBOutlet weak var lessonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    
    func setupCell(){
        
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.5
        cardView.layer.cornerRadius = 8
        //self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        lessonImage.roundCorners(corners: [.topLeft,.topRight], radius: 8)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
