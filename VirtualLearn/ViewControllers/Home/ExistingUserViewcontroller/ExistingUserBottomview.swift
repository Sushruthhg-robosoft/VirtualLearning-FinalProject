//
//  ExisistingUserBottomview.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import UIKit

class ExistingUserBottomview: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var allBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var popularBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var newestBtn: ChoiceOfCourseCustomButton!
    var mainshared = mainViewModel.mainShared
    @IBOutlet weak var ongoingColectionView: UICollectionView!
    
    
    @IBOutlet weak var choiceOfUrCourseCollectionView: UICollectionView!
    
    @IBOutlet weak var topCourse1Label: UILabel!
    @IBOutlet weak var topCourse1CollectionView: UICollectionView!
    
    @IBOutlet weak var topCourse1: TopCourseSectionView!
    @IBOutlet weak var topCourse2: TopCourseSectionView!
    
    var allCourse = false
    var newestCourse = false
    var popularCourse = false
    let mainShared = mainViewModel()
    var courseSet: [UIImage] = [#imageLiteral(resourceName: "img_course1_bg"), #imageLiteral(resourceName: "img_course2_bg")]
    var delegate: clickButtons?
    var shared = ViewModel.shared
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        UINib(nibName: "ExistingUserBottomview", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(backView)
        backView.frame = self.bounds
        
        allCourse = true
        allBtn.isSelected()
        popularBtn.notSelected()
        newestBtn.notSelected()
        initCollectionView()
        // topCourse2.topCourseTitle.text = "Top courses in Design"
        topCourse2.topCourseLabel.text = "Top courses in Design"
        
        mainshared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
            
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
        mainshared.categoriesViewModelShared.getCategories(token: mainshared.token) {
            print("inside Existing Function")
            DispatchQueue.main.async {
                print("inside Existing Dispatch")
                print(self.mainshared.categoriesViewModelShared.listofCategories.count)
                
                
                self.categoriesCollectionView.reloadData()
            }
        } fail: {
            print("fail")
        }
        
        mainshared.homeViewModelShared.getPopularCourseCategory1Details(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.topCourse1.topCourse = data
                self.topCourse1.topCourseCollectionView.reloadData()
            }
            
            
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
        mainshared.homeViewModelShared.getPopularCourseCategory2Details(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.topCourse2.topCourse = data
                self.topCourse2.topCourseCollectionView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
    }
    @IBAction func design(_ sender: Any) {
        
    }
    @IBAction func onClickSeeAll(_ sender: Any) {
        
        shared.delegate?.onClickSeeAllCategories()
        
    }
    
    @IBAction func seeallChoiceofYourcourse(_ sender: Any) {
        
        shared.delegate?.onclickChooseInAllCourse(isNewest: self.newestCourse, isPopular: self.popularCourse, isAllCourse: self.allCourse)
    }
    
    
    @IBAction func onClickAll(_ sender: Any) {
        self.allCourse = true
        self.newestCourse = false
        self.popularCourse = false
        allBtn.isSelected()
        popularBtn.notSelected()
        newestBtn.notSelected()
        mainshared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
            
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
    }
    
    
    
    @IBAction func onClickPopular(_ sender: Any) {
        self.popularCourse = true
        self.allCourse = false
        self.newestCourse = false
        
        allBtn.notSelected()
        popularBtn.isSelected()
        newestBtn.notSelected()
        mainshared.homeViewModelShared.getPopularCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
    }
    
    @IBAction func onClickNewest(_ sender: Any) {
        self.newestCourse = true
        self.allCourse = false
        self.popularCourse = false
        
        allBtn.notSelected()
        popularBtn.notSelected()
        newestBtn.isSelected()
        mainshared.homeViewModelShared.getNewestCourseDetails(token: mainShared.token) { (data) in
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
        } fail: {error in
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
    }
    private func initCollectionView() {
        let nib = UINib(nibName: "ChoiceOfYourCourseCollectionViewCell", bundle: nil)
        choiceOfUrCourseCollectionView.register(nib, forCellWithReuseIdentifier: "choiceCell")
        choiceOfUrCourseCollectionView.dataSource = self
        choiceOfUrCourseCollectionView.delegate = self
        
        let categoryNib = UINib(nibName: "CategoriesCellCollectionViewCell", bundle: nil)
        categoriesCollectionView.register(categoryNib, forCellWithReuseIdentifier: "cetegoryCell")
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case choiceOfUrCourseCollectionView:
            return mainshared.homeViewModelShared.allCourse.count
            
        case categoriesCollectionView :
            
            print("Inside switch")
            return mainshared.categoriesViewModelShared.listofCategories.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case choiceOfUrCourseCollectionView :
            guard let cell = choiceOfUrCourseCollectionView.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as? ChoiceOfYourCourseCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
                
            }
            cell.cardTitle.text = mainshared.homeViewModelShared.allCourse[indexPath.row].categoryName
            cell.lessonName.text = mainshared.homeViewModelShared.allCourse[indexPath.row].courseName
            cell.numberOfChapters.text = "\(mainshared.homeViewModelShared.allCourse[indexPath.row].totalNumberOfChapters) Chapters"
            let url = URL(string: mainshared.homeViewModelShared.allCourse[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.lessonImage.image = UIImage(data: data!)
            print(mainshared.homeViewModelShared.allCourse[indexPath.row].courseId)
            //cell.courseId = mainShared.homeViewModelShared.allCourse[indexPath.row].courseId
            
            
            return cell
            
        case categoriesCollectionView :
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "cetegoryCell", for: indexPath) as? CategoriesCellCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
                
            }
            cell.categoryName.text = mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
            cell.categoryId = mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categoryId
            let url = URL(string: mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
            let data = try? Data(contentsOf: url!)
            cell.categoryImage.image = UIImage(data: data!)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch collectionView {
        case choiceOfUrCourseCollectionView :
            
            shared.delegate?.onClickChoiceofYourCourse(courseId: mainshared.homeViewModelShared.allCourse[indexPath.row].courseId)
            
        case categoriesCollectionView :
            let cell = self.categoriesCollectionView.cellForItem(at: indexPath) as? CategoriesCellCollectionViewCell
            shared.delegate?.onClickCategory(categoryName: (cell?.categoryName.text)!, categoryId: mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categoryId)
            
            
            
        default:
            print("Default")
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case categoriesCollectionView :
            
            return 5
        default:
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case categoriesCollectionView :
            
            return 5
        default:
            return 10
        }
    }
    
}



