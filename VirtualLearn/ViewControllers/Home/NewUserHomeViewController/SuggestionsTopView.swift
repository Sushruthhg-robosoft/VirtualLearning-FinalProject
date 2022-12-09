//
//  SuggestionsTopView.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit

class SuggestionsTopView: UIView {
    
    
    var arrImages : [UIImage] = [#imageLiteral(resourceName: "img_banner1_home"), #imageLiteral(resourceName: "img_mycourse_completed3")]
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var suggestionsCollectionView: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "SuggestionsTopView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        initCollectionView()
    }
}


extension SuggestionsTopView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = suggestionsCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCell", for: indexPath) as? SuggestionsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.cellImage.image = arrImages[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 260.0 , height: 140.0)
        
        //return CGSize(width: size, height: onboardingCollectionView.frame.height)
    }
    
    
    private func initCollectionView() {
        let nib = UINib(nibName: "SuggestionsCollectionViewCell", bundle: nil)
        suggestionsCollectionView.register(nib, forCellWithReuseIdentifier: "suggestionCell")
        suggestionsCollectionView.dataSource = self
        suggestionsCollectionView.delegate = self
    }
    
    
}
