//
//  HeaderView.swift
//  Chapters
//
//  Created by Manish R T on 12/12/22.
//

import Foundation
import UIKit
 

protocol headerDelegate {
    func callHeader(idx: Int)
}

class HeaderView: UITableViewHeaderFooterView{
    
    var secIndex: Int?
    var delegateForHeader: headerDelegate?
    var expanded = false
    let title = UILabel()
    let image = UIImageView()
    let button =  UIButton()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHeader()
    }
    
    func configureHeader(){
        
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        title.font = title.font.withSize(12)
        //contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(button)
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        if !expanded{
//            button.setImage(#imageLiteral(resourceName: "icn_chapter maximise"), for: .normal)
//        }
//        else{
//            button.setImage(#imageLiteral(resourceName: "icn_chapter maximise"), for: .normal)
//        }
        
        button.addTarget(self, action: #selector(onClickHeaderView ), for: .touchUpInside)
        NSLayoutConstraint.activate([
            
            button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor,constant: 8),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            
            
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                                           constant: 8),
            title.trailingAnchor.constraint(equalTo:
                                                contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    @objc func onClickHeaderView(){
        
       expanded = true
        button.setImage(#imageLiteral(resourceName: "icn_chapter maximise"), for: .normal)
        if let index = secIndex{
            delegateForHeader?.callHeader(idx: index)
        }
    }
}
