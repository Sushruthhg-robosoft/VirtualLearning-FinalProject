//
//  File.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import Foundation
import UIKit
class customChooseCourseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBorder()
    }
    func setBorder(){
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
