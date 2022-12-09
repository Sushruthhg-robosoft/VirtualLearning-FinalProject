//
//  ChoiseOfCourseCustomButton.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import Foundation
import UIKit

class ChoiceOfCourseCustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setCornerRadius()
    }
    
    
    func isSelected(){
        
        self.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.9058823529, blue: 0.9607843137, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 1), for: .normal)
    }
    
    func notSelected(){
        
        self.backgroundColor = .clear
        self.setTitleColor(#colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1), for: .normal)
    }
    
    func setCornerRadius(){
        
        self.layer.cornerRadius = 5
    }
}
