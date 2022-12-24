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
        
//        cardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//        cardView.layer.shadowOpacity = 100
//        cardView.layer.shadowRadius = 10
//        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.cornerRadius = 8
//        cardView.layer.masksToBounds = false
//        cardView.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5

        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.4
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
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
