//
//  pagecontrolExtension.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import Foundation

import UIKit

class ExtendedpageControll: UIPageControl{

 var currentpage : Int                  = 0{didSet{reloadView()}}
 var currentIndicatorColor: UIColor     = .black
 var indicatorColor: UIColor            = UIColor(white: 0.9, alpha: 1)
 var circleIndicator: Bool              = false
 private var dotView                    = [UIView]()
 private let spacing: CGFloat           = 6
 private lazy var  extraWidth: CGFloat  = circleIndicator ? 6 : 4


    func configView(numberOfPage: Int){
    backgroundColor = .clear
    (0..<numberOfPage).forEach { _ in
        let view = UIView()
        addSubview(view)
        dotView.append(view)
    }
 }

 private func reloadView(){
    dotView.forEach{$0.backgroundColor = indicatorColor}
    dotView[currentpage].backgroundColor = currentIndicatorColor
    UIView.animate(withDuration: 0.2) {
        self.dotView[self.currentpage].frame.origin.x   = self.dotView[self.currentpage].frame.origin.x - self.extraWidth
        self.dotView[self.currentpage].frame.size.width = self.dotView[self.currentpage].frame.size.width + (self.extraWidth * 2)
    }
}

}
