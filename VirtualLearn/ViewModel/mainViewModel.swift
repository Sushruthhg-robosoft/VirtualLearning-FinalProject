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
    var homeViewModelShared = HomeViewModel()
    var isExisting = false
    var loginUserName: String?
    
    
    let token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdW1hbnRocHJhYmh1IiwiZXhwIjoxNjcxMDM2Mjg1LCJpYXQiOjE2NzEwMDAyODV9.r_-6vPg-9s8WrbcYQdIN9kInYJdUtQCv8NKtFw4nzEgCCTfGRMGTWpXmx3qQCXlEQ7I-Pid1htCLyQ3bR1cKbQ"
    
    
}
