//
//  OnboardingCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self )
    
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingTitleTxt: UILabel!
    @IBOutlet weak var onboardingDescrption: UILabel!
    
    
    
    func setup(_ slide: OnboardingSlide){
        
        onboardingImage.image = slide.onboardingImage
        onboardingTitleTxt.text = slide.title
        onboardingDescrption.text = slide.onboardingDescription
    }
}
