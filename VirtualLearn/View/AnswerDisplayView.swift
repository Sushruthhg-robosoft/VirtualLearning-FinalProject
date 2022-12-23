//
//  AnswerDisplayView.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 23/12/22.
//

import Foundation
import UIKit

class AnswerDisplay: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    func addBorder() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.1
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 6
    }

    
}
