//
//  Chapters.swift
//  Chapters
//
//  Created by Manish R T on 12/12/22.
//

import Foundation

class Chapter{
    
    var chapterName: String?
    var lessonNames = [String]()
    var isExpandable: Bool
    
    init(chapterName: String, lessonNames: [String], isExpandable: Bool) {
        self.chapterName = chapterName
        self.lessonNames = lessonNames
        self.isExpandable = isExpandable
    }
    
}
