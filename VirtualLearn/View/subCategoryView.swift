//
//  subCategoryView.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 15/12/22.
//

import Foundation
import UIKit
class SubCategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBorder()
    }
    func setBorder(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 6
        self.layer.borderColor = #colorLiteral(red: 0.4784313725, green: 0.4784313725, blue: 0.4784313725, alpha: 1)
    }
}
