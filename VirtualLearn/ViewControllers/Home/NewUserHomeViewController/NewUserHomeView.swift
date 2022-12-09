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
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
       // bottomView.delegate = delegate
        
//        testDelegate?.printHome()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "NewUserHomeView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(BackView)
        BackView.frame = self.bounds
//        testDelegate?.printHome()
    }
    
}
