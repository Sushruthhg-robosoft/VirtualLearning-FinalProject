//
//  customHamLable.swift
//  hamburger
//
//  Created by Manish R T on 07/12/22.
//

import Foundation
import UIKit

class customHamLable: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setCornerRadius()
    }
    
    func setCornerRadius(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }

}
