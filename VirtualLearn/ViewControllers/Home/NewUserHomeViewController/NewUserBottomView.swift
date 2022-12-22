//
//  NewUserBottomView.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit

protocol clickButtons {
    func onClickSeeAllCategories()
    func onClickChoiceofYourCourse()
    func onclickChooseInAllCourse()
}

class NewUserBottomView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var allBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var popularBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var newestBtn: ChoiceOfCourseCustomButton!
    
    var mainshared = mainViewModel.mainShared
    


    @IBOutlet weak var choiceOfUrCourseCollectionView: UICollectionView!
    
    @IBOutlet weak var topCourse1Label: UILabel!
    @IBOutlet weak var topCourse1CollectionView: UICollectionView!

    @IBOutlet weak var topCourse1: TopCourseSectionView!
    @IBOutlet weak var topCourse2: TopCourseSectionView!
    
    
    var courseSet: [UIImage] = [#imageLiteral(resourceName: "img_course1_bg"), #imageLiteral(resourceName: "img_course2_bg")]
    var delegate: clickButtons?
    var toCourse1Obj: UIView?
    var toCourse2Obj: UIView?
    var shared = ViewModel.shared
    var mainShared = mainViewModel.mainShared
    var array = ["nbvhj", "afka", "aef", "nbvhj", "afka", "aef", "nbvhj", "afka", "aef"]
    var array2 = ["123", "7456", "67", "nbvhj", "afka", "aef", "nbvhj", "afka", "aef"]
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "NewUserBottomView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(backView)
        backView.frame = self.bounds
        
        allBtn.isSelected()
        popularBtn.notSelected()
        newestBtn.notSelected()
        initCollectionView()
        topCourse2.topCourseLabel.text = "Design"
        
        

        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
            
        } fail: {
            print("fail")
        }

        
        
        mainshared.homeViewModelShared.getPopularCourseCategory1Details(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.topCourse1.topCourse = data
                self.topCourse1.topCourseCollectionView.reloadData()
            }
            
            
        } fail: {
            print("fail")
        }
        
        mainshared.homeViewModelShared.getPopularCourseCategory2Details(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.topCourse2.topCourse = data
                self.topCourse2.topCourseCollectionView.reloadData()
            }
        } fail: {
            print("fail")
        }
        
        mainshared.categoriesViewModelShared.getCategories(token: mainshared.token) {
            print("insideFunction")
            DispatchQueue.main.async {
                print("inside Dispatch")

                self.categoriesCollectionView.reloadData()
            }
        } fail: {
            print("fail")
        }






        
    }
    @IBAction func design(_ sender: Any) {
        
    }
    @IBAction func onClickSeeAll(_ sender: Any) {
       // print(shared.delegate)
   
        shared.delegate?.onClickSeeAllCategories()
        

        
    }
    
    @IBAction func onClickAll(_ sender: Any) {
        allBtn.isSelected()
        popularBtn.notSelected()
        newestBtn.notSelected()
        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainshared.token) { (data) in
            
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
            
        } fail: {
            print("fail")
        }
    }
    
    @IBAction func onClickPopular(_ sender: Any) {
        
        allBtn.notSelected()
        popularBtn.isSelected()
        newestBtn.notSelected()
        mainshared.homeViewModelShared.getPopularCourseDetails(token: mainshared.token) { (data) in
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
        } fail: {
            print("fail")
        }

    }
    
    @IBAction func onClickNewest(_ sender: Any) {
        
        allBtn.notSelected()
        popularBtn.notSelected()
        newestBtn.isSelected()
        mainshared.homeViewModelShared.getNewestCourseDetails(token: mainshared.token) { (data) in
            DispatchQueue.main.async {
                self.choiceOfUrCourseCollectionView.reloadData()
            }
        } fail: {
            print("fail")
        }

        
    }
    
    @IBAction func onclickChooseInAllCourse(_ sender: Any) {
        
       
        shared.delegate?.onclickChooseInAllCourse()
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
        case choiceOfUrCourseCollectionView :
            
            return mainShared.homeViewModelShared.allCourse.count
        case categoriesCollectionView :
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
            
            cell.cardTitle.text = mainShared.homeViewModelShared.allCourse[indexPath.row].categoryName
            cell.lessonName.text = mainShared.homeViewModelShared.allCourse[indexPath.row].courseName
            cell.numberOfChapters.text = "\(mainShared.homeViewModelShared.allCourse[indexPath.row].totalNumberOfChapters) Chapters"
            let url = URL(string: mainShared.homeViewModelShared.allCourse[indexPath.row].courseImage)
            let data = try? Data(contentsOf: url!)
            cell.lessonImage.image = UIImage(data: data!)

            return cell
            
        case categoriesCollectionView :
            guard let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "cetegoryCell", for: indexPath) as? CategoriesCellCollectionViewCell else {
                fatalError("can't dequeue CustomCell")
                
            }
            cell.categoryName.text = mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
                let url = URL(string: mainshared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
                let data = try? Data(contentsOf: url!)
                cell.categoryImage.image = UIImage(data: data!)
            
            
//            for i in mainshared.categoriesViewModelShared.listofCategories{
//                print(i.categotyName)
//                cell.categoryName.text = i.categotyName
//                let url = URL(string: i.categoryImage)
//                let data = try? Data(contentsOf: url!)
//                cell.categoryImage.image = UIImage(data: data!)
//            }
            
            
//            cell.cardTitle.text = mainShared.homeViewModelShared.allCourse[indexPath.row].categoryName
//            cell.lessonName.text = mainShared.homeViewModelShared.allCourse[indexPath.row].courseName
//            cell.numberOfChapters.text = "\(mainShared.homeViewModelShared.allCourse[indexPath.row].totalNumberOfChapters) Chapters"
//            let url = URL(string: mainShared.homeViewModelShared.allCourse[indexPath.row].courseImage)
//            let data = try? Data(contentsOf: url!)
//            cell.lessonImage.image = UIImage(data: data!)

            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        shared.delegate?.onClickChoiceofYourCourse()
    }
    

    
}



