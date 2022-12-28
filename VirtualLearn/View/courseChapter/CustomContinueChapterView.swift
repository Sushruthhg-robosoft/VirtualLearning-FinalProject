//
//  CustomContinueChapterView.swift
//  Chapters
//
//  Created by Santhosh Patkar on 12/12/22.
//

import Foundation
import UIKit

class CustomContinueChapterView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCorner()
    }
    
    func setCorner(){
        
        self.layer.cornerRadius = 10
    }
}
