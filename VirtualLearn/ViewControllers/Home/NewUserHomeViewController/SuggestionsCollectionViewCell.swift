//
//  SuggestionsCollectionViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit

class SuggestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    func setupCell(){
        self.layer.cornerRadius = 5
    }

}
