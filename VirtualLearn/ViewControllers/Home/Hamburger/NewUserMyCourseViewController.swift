//
//  NewUserMyCourseViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class NewUserMyCourseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
    
    var mainShared = mainViewModel.mainShared

    @IBOutlet weak var newUserCategoryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = self.loader()

        
        newUserCategoryCollectionView.delegate = self
        newUserCategoryCollectionView.dataSource = self

        mainShared.categoriesViewModelShared.getCategories(token: mainShared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.newUserCategoryCollectionView.reloadData()
            }
        } fail: {
            self.stopLoader(loader: loader)
        }

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainShared.categoriesViewModelShared.listofCategories.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewUserCategoryCollectionViewCell
        
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
