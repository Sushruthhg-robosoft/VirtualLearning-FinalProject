//
//  OngoingView.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import UIKit

class OngoingView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
  
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var ongoingCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        UINib(nibName: "OngoingView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(backView)
        backView.frame = self.bounds
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "ExistingCollectionViewCell", bundle: nil)
        ongoingCollectionView.register(nib, forCellWithReuseIdentifier: "existingUserCell")
        ongoingCollectionView.dataSource = self
        ongoingCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = ongoingCollectionView.dequeueReusableCell(withReuseIdentifier: "existingUserCell", for: indexPath) as? ExistingCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
            
        }
       
        return cell
    }
}
