//
//  ViewController.swift
//  VLLoginVC
//
//  Created by Sushruth H G on 07/12/22.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var shared = mainViewModel.mainShared
    
    override func viewDidLoad() {

        collectionView.delegate = self
        collectionView.dataSource = self

        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loader = self.loader()
        shared.categoriesViewModelShared.getCategories(token: shared.token) {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.collectionView.reloadData()
            }
        } fail: {
            print("error")
        }
    }

    @IBAction func onClickBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)

    }
    

    @IBAction func onCLickSearch(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else{return}
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shared.categoriesViewModelShared.listofCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as? CategoryCollectionViewCell
        item?.courseName.text = shared.categoriesViewModelShared.listofCategories[indexPath.row].categotyName
        let url = URL(string: shared.categoriesViewModelShared.listofCategories[indexPath.row].categoryImage)
        let data = try? Data(contentsOf: url!)
        item?.courseImage.image = UIImage(data: data!)
        return item!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryInformationViewController") as? CategoryInformationViewController
        if let viewController = vc{
            viewController.categoryId = shared.categoriesViewModelShared.listofCategories[indexPath.row].categoryId
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 3
        let width = 110
        let side = 88
        let rem = width % columns
        let addOne = indexPath.row % columns < rem
        let ceilWidth = addOne ? side + 1 : side
        return CGSize(width: ceilWidth, height: side)
    }
    
}

