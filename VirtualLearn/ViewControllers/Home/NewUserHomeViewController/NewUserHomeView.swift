//
//  NewUserHomeView.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit
protocol test {
    func printHome()
}


class NewUserHomeView: UIView {

    
    @IBOutlet var BackView: UIView!
    @IBOutlet weak var bottomView: NewUserBottomView!
    var delegate: clickButtons?
    @IBOutlet weak var topView: SuggestionsTopView!
    var testDelegate : test?
    //var bannerImages = [String]()
    var shared = mainViewModel.mainShared
    @IBOutlet weak var existingUserBottomView: ExistingUserBottomview!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "NewUserHomeView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(BackView)
        BackView.frame = self.bounds
       
        
        shared.homeViewModelShared.getOngoingCourseForHome(token: shared.token) {
            DispatchQueue.main.async {
                if self.shared.homeViewModelShared.ongoingCourses.count > 0{
                    self.existingUser()
                }
                else{
                    self.newUser()
                }
            }
        } fail: { error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
            
        }
        

    }
    
    
    func existingUser(){
        bottomView.isHidden = true
        existingUserBottomView.isHidden = false
       
    }
    
    func newUser(){
        bottomView.isHidden = false
        existingUserBottomView.isHidden = true
    }
    
    func returnObj() -> UIView{
        
        return BackView
    }
}
