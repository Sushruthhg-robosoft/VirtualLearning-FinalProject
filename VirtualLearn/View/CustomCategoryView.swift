//
//  ViewExtension.swift
//  VLLoginVC
//
//  Created by Sushruth H G on 07/12/22.
//

import Foundation

import UIKit
class customCategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBorder()
    }
    func setBorder(){
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8588235294, blue: 0.8823529412, alpha: 1)
    }
}
