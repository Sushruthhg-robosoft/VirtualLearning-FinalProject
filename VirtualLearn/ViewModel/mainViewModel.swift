//
//  mainViewModel.swift
//  VirtualLearn
//
//  Created by Manish R T on 13/12/22.
//

import Foundation

class mainViewModel{
    
    static var mainShared = mainViewModel()
    var notificationViewModelShared = NotificationViewModel()
    var myCourseViewModelShared = myCourseViewModel()
    var categoriesViewModelShared = CategoryViewModel()
    var courseDetailsViewModelShared = courseDetailsViewModel()
    var chaptersDetailsViewModelShared = ChaptersViewModel()
    var homeViewModelShared = HomeViewModel()
    var isExisting = false
    var loginUserName: String?
    
    
    var token = ""
    
    
}
