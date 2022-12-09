//
//  TopCourseSectionView.swift
//  VirtualLearn
//
//  Created by Manish R T on 09/12/22.
//

import UIKit

class TopCourseSectionView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var topCourseLabel: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var topCourseCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        UINib(nibName: "TopCourseSectionView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        
        initCollectionView()
    }

}


extension TopCourseSectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = topCourseCollectionView.dequeueReusableCell(withReuseIdentifier: "TopCourseSectionCell", for: indexPath) as? TopCourseSectionCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        
        return cell
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "TopCourseSectionCollectionViewCell", bundle: nil)
        topCourseCollectionView.register(nib, forCellWithReuseIdentifier: "TopCourseSectionCell")
        topCourseCollectionView.dataSource = self
        topCourseCollectionView.delegate = self
    }
    
}
