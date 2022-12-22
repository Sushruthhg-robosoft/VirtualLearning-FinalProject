//
//  Ctegory.swift
//  VirtualLearn
//
//  Created by Manish R T on 15/12/22.
//

import Foundation
class Category{
    
    var categoryId: String
    var categoryImage: String
    var categotyName: String
    
    init(categoryId: String, categoryImage: String, categotyName: String) {
        
        self.categoryId = categoryId
        self.categoryImage = categoryImage
        self.categotyName = categotyName
    }
}

class CategotyDetails{
    var categoryName: String
    var chapterCount: String
    var courseId: String
    var courseImage: String
    var courseName: String
    var courseDuration: String
    init(categoryName: String,chapterCount: String,courseId: String,courseImage: String,courseName: String, courseDuration: String) {
        self.categoryName = categoryName
        self.chapterCount = chapterCount
        self.courseId = courseId
        self.courseImage = courseImage
        self.courseName = courseName
        self.courseDuration = courseDuration
    }
}


class subCategory{
    
    var subCategoryId: String
    var subCategotyName: String
    
    init(subCategoryId: String, subCategotyName: String) {
        self.subCategoryId = subCategoryId
        self.subCategotyName = subCategotyName
    }

}
