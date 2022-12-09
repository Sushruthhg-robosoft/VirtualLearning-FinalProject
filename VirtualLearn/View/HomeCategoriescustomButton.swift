//
//  HomeCategoriescustomButton.swift
//  VirtualLearn
//
//  Created by Manish R T on 07/12/22.
//

import Foundation
import UIKit

class HomeCategoriesCustomButton: UIButton{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        applyDesign()
    }
    
    func applyDesign(){
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9450980392, alpha: 1)
        self.layer.cornerRadius = 5
        //self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 2), forImageIn: .normal)
        //self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    }
}
