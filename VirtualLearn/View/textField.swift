//
//  textField.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import Foundation

import UIKit

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
