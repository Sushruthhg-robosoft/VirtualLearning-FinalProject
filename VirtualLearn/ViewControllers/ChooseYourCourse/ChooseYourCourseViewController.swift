//
//  ChooseYourCourseViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class ChooseYourCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: customChooseCourseView!
    @IBOutlet weak var searchTextField: UITextField!
    var mainShared = mainViewModel.mainShared
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
     
        
        tableView.delegate = self
        tableView.dataSource = self
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.searchView.setBorder()
        self.searchTextField.removeBorder()
        super.viewDidLoad()
        let loader = self.loader()
        mainShared.homeViewModelShared.getAllCourseDeatils(token: mainShared.token) { (data) in
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.tableView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
        }
        
        mainShared.categoriesViewModelShared.getCategories(token: mainShared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.categoriesCollectionView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
        }


//        let columnLayout = UICollectionViewLeftAlignedLayout()
//
//             if #available(iOS 10.0, *) {
//                 columnLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//             } else {
//                 columnLayout.estimatedItemSize = CGSize(width: 41, height: 41)
//             }
//             categoriesCollectionView.collectionViewLayout = columnLayout
//

    }
    
    @IBAction func onclickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension ChooseYourCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainShared.homeViewModelShared.allCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChooseYourCourseTableViewCell
        cell.couseName.text = mainShared.homeViewModelShared.allCourse[indexPath.row].courseName
        cell.courseCategory.text = mainShared.homeViewModelShared.allCourse[indexPath.row].categoryName
        cell.numberofChapters.text = "\(mainShared.homeViewModelShared.allCourse[indexPath.row].totalNumberOfChapters) chapters"
        let url = URL(string: mainShared.homeViewModelShared.allCourse[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.courseImage.image = UIImage(data: data!)
        return cell
    }
    
    
    
}
extension ChooseYourCourseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainShared.categoriesViewModelShared.listofCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChooseYourCourseCollectionViewCell
        
        cell.categoryName.text = mainShared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
        
        let url = URL(string: mainShared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
        let data = try? Data(contentsOf: url!)
        
        cell.categoryImage.image = UIImage(data: data!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    
}

//final class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
//
//  private var layouts: [IndexPath: UICollectionViewLayoutAttributes] = [:]
//
//  override func prepare() {
//    super.prepare()
//    layouts = [:]
//  }
//
//  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//    var newAttributesArray = [UICollectionViewLayoutAttributes]()
//    let superAttributesArray = super.layoutAttributesForElements(in: rect)!
//    for (index, attributes) in superAttributesArray.enumerated() {
//      if index == 0 || superAttributesArray[index - 1].frame.origin.y != attributes.frame.origin.y {
//        attributes.frame.origin.x = sectionInset.left
//      } else {
//        let previousAttributes = superAttributesArray[index - 1]
//        let previousFrameRight = previousAttributes.frame.origin.x + previousAttributes.frame.width
//        attributes.frame.origin.x = previousFrameRight + minimumInteritemSpacing
//      }
//      newAttributesArray.append(attributes)
//    }
//    newAttributesArray.forEach { layouts[$0.indexPath] = $0 }
//    return newAttributesArray
//  }
//
//  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//    layouts[indexPath]
//  }
//}
