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
    var bannerImages = [String]()
    var shared = mainViewModel.mainShared
    @IBOutlet weak var existingUserBottomView: ExistingUserBottomview!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
       // bottomView.delegate = delegate
        
//        testDelegate?.printHome()
//        bottomView.isHidden = true
//        existingUserBottomView.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "NewUserHomeView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(BackView)
        BackView.frame = self.bounds
        if shared.isExisting{
            existingUser()
        }
        else{
            newUser()
        }
        
        DispatchQueue.main.async {
            print("dsmjfhbiuhfdsfuj",self.bannerImages.count)
        }
        
//        testDelegate?.printHome()
        print("c1 address: \(Unmanaged.passUnretained(BackView).toOpaque())")
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
