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
