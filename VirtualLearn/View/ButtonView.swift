//
//  ButtonView.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 06/12/22.
//

import Foundation

import UIKit

extension UIButton {
    
    func addingRadius() {
        self.layer.cornerRadius = 6
    }
    
    func setBorder(){
        
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.3607843137, blue: 0.3019607843, alpha: 1)
    }
}
