//
//  Certificate.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 16/12/22.
//

import Foundation


class Certificate {
    
    var grade: Int
    var certificateLink: String
    
    init(grade: Int, certificateLink: String) {
        
        self.grade = grade
        self.certificateLink = certificateLink
    }
}
