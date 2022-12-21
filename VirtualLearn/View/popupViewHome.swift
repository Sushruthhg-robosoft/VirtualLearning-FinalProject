//
//  popupViewHome.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import Foundation
import UIKit
class customPopHomeView : UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.2
       // self.layer.shadowRadius = 1
        
    }
}
