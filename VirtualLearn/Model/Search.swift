//
//  Search.swift
//  VirtualLearn
//
//  Created by Sushruth H G on 21/12/22.
//

import Foundation


class Search {
    
    var courseId : Int
    var courseName: String
    var categoryName : String
    var noOfChapters : Int
    var courseImage : String
    
    init(courseId: Int, courseName: String, categoryName: String, noOfChapters: Int, courseImage: String) {
        
        self.courseId = courseId
        self.courseName = courseName
        self.categoryName = categoryName
        self.noOfChapters = noOfChapters
        self.courseImage = courseImage
    }
}
