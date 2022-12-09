//
//  customHamburgerButtons.swift
//  hamburger
//
//  Created by Manish R T on 07/12/22.
//

import Foundation
import UIKit
class customHabButtons: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setPadding()
    }
    
    
    func setPadding(){
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16)
    }
}
