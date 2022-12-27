//
//  BorderButton.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 14/12/22.
//

import Foundation
import UIKit

class CustomBorderButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addBorder()
    }
    func addBorder() {
//        self.titleEdgeInsets = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1).cgColor
        self.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 0)
    }
}
