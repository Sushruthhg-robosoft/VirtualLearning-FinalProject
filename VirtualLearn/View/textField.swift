//
//  textField.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import Foundation

import UIKit

class borderlessTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        noBorder()
    }
    
    func noBorder() {
        self.borderStyle = .none
    }
}

extension UITextField {
    
    func removeBorder() {
        self.borderStyle = .none
    }
    
    func lineheight() {
        var frameRect = self.frame;
        frameRect.size.height = 20
        self.frame = frameRect;
    }
}
