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
    var shared = mainViewModel.mainShared
    var featuredCourse = [HomeCourse]()
    var allCourses = [HomeCourse]()
    var categoryName = ""
    var categoryId = ""
    
    var subCategoriesfield = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionViewForTop(collectionView: courseToGetStartedCollectionView)
        initCollectionViewForTop(collectionView: featureCourseCollectionView)
//        initCollectionViewForsubCategory(collectionView:subCategoryCollectionView)
        
        CategoryLabel.text = categoryName
        let loader = self.loader()
        shared.categoriesViewModelShared.getCategegoryDetailsById(token: shared.token, categoryId: categoryId, limit: "", page: "") {
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.courseToGetStartedCollectionView.reloadData()
                self.shared.categoriesViewModelShared.getSubCategoryDetails(token: self.shared.token, categoryId: self.categoryId) {
                    DispatchQueue.main.async {
                        self.subCategoryCollectionView.reloadData()
                    }
                    
                } fail: {
                    
                }

            }
        } fail: {
            self.stopLoader(loader: loader)
        }
        let loader2 = self.loader()
        shared.homeViewModelShared.getNewestCourseDetails(token: shared.token) { (data) in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader2)
                self.featuredCourse = data
                self.featureCourseCollectionView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader2)
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        let loader3 = self.loader()
        shared.homeViewModelShared.getPopularCourseDetails(token: shared.token) { (data) in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader3)
                self.allCourses = data
                self.allCourseTableView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                self.stopLoader(loader: loader3)
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
      

       
        
    
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else{return}
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func initCollectionViewForTop(collectionView: UICollectionView) {
        let nib = UINib(nibName: "TopCourseSectionCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TopCourseSectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
//    private func initCollectionViewForsubCategory(collectionView: UICollectionView) {
//        let nib = UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "subCategoriesCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
    
    
}
extension CategoryInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case courseToGetStartedCollectionView :
            return shared.categoriesViewModelShared.categoryDetails.count
        case featureCourseCollectionView :
            return self.featuredCourse.count
        case subCategoryCollectionView :
            
            return shared.categoriesViewModelShared.subCategoryDetails.count
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case courseToGetStartedCollectionView :
            guard let cell = courseToGetStartedCollectionView.dequeueReusableCell(withReuseIdentifier: "TopCourseSectionCell", for: indexPath) as? TopCourseSectionCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            self.CategoryLabel.text = shared.categoriesViewModelShared.categoryDetails[indexPath.row].categoryName
            cell.headingLabel.text = shared.categoriesViewModelShared.categoryDetails[indexPath.row].courseName
            let url = URL(string: shared.categoriesViewModelShared.categoryDetails[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.courseImage.image = UIImage(data: data!)
            cell.chapterCount.text = "\(shared.categoriesViewModelShared.categoryDetails[indexPath.row].chapterCount) Chapters"
            cell.duration.text = "\(shared.categoriesViewModelShared.categoryDetails[indexPath.row].courseDuration) mins"
            return cell
        case featureCourseCollectionView :
            guard let cell = courseToGetStartedCollectionView.dequeueReusableCell(withReuseIdentifier: "TopCourseSectionCell", for: indexPath) as? TopCourseSectionCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
            }
            
            cell.headingLabel.text = self.featuredCourse[indexPath.row].courseName
            let url = URL(string: self.featuredCourse[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.courseImage.image = UIImage(data: data!)
            cell.chapterCount.text = "\(self.featuredCourse[indexPath.row].totalNumberOfChapters) Chapters"
            cell.duration.text = "\(self.featuredCourse[indexPath.row].videoLength) mins"
            
            return cell
        case subCategoryCollectionView :
            guard let cell = subCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "subCategoriesCell", for: indexPath) as? SubCategoriesCollectionViewCell else {
                
                fatalError("can't dequeue CustomCell")
            }
            
            cell.subCategory.text = shared.categoriesViewModelShared.subCategoryDetails[indexPath.row].subCategotyName
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryId = shared.homeViewModelShared.allCourse[indexPath.row].courseId
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
    
}


extension CategoryInformationViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.allCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CatergoryCourseDisplayTableViewCell
        cell.courseName.text = self.allCourses[indexPath.row].courseName
        cell.categoryNAme.text = self.allCourses[indexPath.row].categoryName
        let url = URL(string: self.allCourses[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        cell.totalNumberOfChapters.text = "\(self.allCourses[indexPath.row].totalNumberOfChapters) Chapters"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as! CategoryInformationViewController
        vc.categoryId = shared.homeViewModelShared.allCourse[indexPath.row].courseId
        navigationController?.pushViewController(vc, animated: true)
    }
}

//class FlowLayout: UICollectionViewFlowLayout {
//
//    required init(minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
//        super.init()
//
//        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        self.minimumInteritemSpacing = minimumInteritemSpacing
//        self.minimumLineSpacing = minimumLineSpacing
//        self.sectionInset = sectionInset
//        sectionInsetReference = .fromSafeArea
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
//        guard scrollDirection == .vertical else { return layoutAttributes }
//
//        // Filter attributes to compute only cell attributes
//        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })
//
//        // Group cell attributes by row (cells with same vertical center) and loop on those groups
//        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
//            // Set the initial left inset
//            var leftInset = sectionInset.left
//
//            // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
//            for attribute in attributes {
//                attribute.frame.origin.x = leftInset
//                leftInset = attribute.frame.maxX + minimumInteritemSpacing
//            }
//        }
//
//        return layoutAttributes
//    }

//}
