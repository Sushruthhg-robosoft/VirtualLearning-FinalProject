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
    var isExisting = true
    var loginUserName: String?
    
    
    var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdW1hbnRocHJhYmh1IiwiZXhwIjoxNjcxMzM2OTQxLCJpYXQiOjE2NzEyNTA1NDF9.o6VmZGcISqeQLYDA6gzm9gZlfERpIKJE-pcJELbIzfvYkrEBjKJDbv8Hs2kb-Z2rTiBFZNxffXLZbE4pIoxOjg"
    
    
}
