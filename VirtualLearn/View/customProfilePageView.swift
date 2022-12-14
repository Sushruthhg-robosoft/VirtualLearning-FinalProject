//
//  Shadow.swift
//  ProfileScreen
//
//  Created by Anushree J C on 09/12/22.
//

import Foundation
import UIKit

class customProfilePageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 6
    }

    
}
