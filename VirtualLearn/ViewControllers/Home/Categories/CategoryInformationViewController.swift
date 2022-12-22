//
//  CategoryInformationViewController.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 14/12/22.
//

import UIKit

class CategoryInformationViewController: UIViewController{

    @IBOutlet weak var allCourseTableView: UITableView!
    @IBOutlet weak var courseToGetStartedCollectionView: UICollectionView!
    @IBOutlet weak var featureCourseCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var CategoryLabel: UILabel!
    var categoryName = ""
//    @IBOutlet weak var allCourseTableViewHeight: NSLayoutConstraint!
    
    var subCategoriesfield = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        subCategoriesfield = ["graphic", "uidesign","abc","def","egh","ghi","klm","pqr","stu","vxy","xyz","graphic","uidesign","abc","def","egh","ghi","klm","pqr","stu","vxy"]
        
        initCollectionViewForTop(collectionView: courseToGetStartedCollectionView)
        initCollectionViewForTop(collectionView: featureCourseCollectionView)
        initCollectionViewForsubCategory(collectionView:subCategoryCollectionView)
    
    }
    
    private func initCollectionViewForTop(collectionView: UICollectionView) {
        let nib = UINib(nibName: "TopCourseSectionCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TopCourseSectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func initCollectionViewForsubCategory(collectionView: UICollectionView) {
        let nib = UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "subCategoriesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
}
extension CategoryInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case courseToGetStartedCollectionView :
            guard let cell = courseToGetStartedCollectionView.dequeueReusableCell(withReuseIdentifier: "TopCourseSectionCell", for: indexPath) as? TopCourseSectionCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            return cell
        case featureCourseCollectionView :
            guard let cell = courseToGetStartedCollectionView.dequeueReusableCell(withReuseIdentifier: "TopCourseSectionCell", for: indexPath) as? TopCourseSectionCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            return cell
        case subCategoryCollectionView :
            guard let cell = subCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "subCategoriesCell", for: indexPath) as? SubCategoriesCollectionViewCell else {
                
                fatalError("can't dequeue CustomCell")
            }
            cell.subCategory.text = subCategoriesfield[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case subCategoryCollectionView :
            return CGSize(width: subCategoriesfield[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width + 20, height: 30)
           
        default:
            return "String".size(withAttributes: nil)
        }
            
}
    
}


extension CategoryInformationViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CatergoryCourseDisplayTableViewCell
        return cell
    }
}

class FlowLayout: UICollectionViewFlowLayout {

    required init(minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        super.init()

        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        sectionInsetReference = .fromSafeArea
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttributes }

        // Filter attributes to compute only cell attributes
        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })

        // Group cell attributes by row (cells with same vertical center) and loop on those groups
        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            // Set the initial left inset
            var leftInset = sectionInset.left

            // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }

        return layoutAttributes
    }

}
