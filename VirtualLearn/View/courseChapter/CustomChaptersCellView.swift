//
//  CustomChaptersCellView.swift
//  Chapters
//
//  Created by Santhosh Patkar on 12/12/22.
//

import Foundation

import UIKit
class customChaptersCellView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp(){
        
        self.layer.cornerRadius = 10
    }
}
