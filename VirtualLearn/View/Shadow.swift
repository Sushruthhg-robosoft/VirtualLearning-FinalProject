//
//  Shadow.swift
//  CreatePasswordScreens
//
//  Created by Anushree J C on 09/12/22.
//

import Foundation
import UIKit

class customPasswordView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 6
    }

    
}
