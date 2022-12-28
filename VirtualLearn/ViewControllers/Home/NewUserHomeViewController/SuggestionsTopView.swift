//
//  SuggestionsTopView.swift
//  VirtualLearn
//
//  Created by Manish R T on 08/12/22.
//

import UIKit

class SuggestionsTopView: UIView {
    
    
    var arrImages : [UIImage] = [#imageLiteral(resourceName: "img_banner1_home"), #imageLiteral(resourceName: "img_mycourse_completed3")]
    var bannerImage: [String] = []
    @IBOutlet var view: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var suggestionsCollectionView: UICollectionView!
    var shared = mainViewModel.mainShared
    var storageManger = StorageManeger.shared
    var userName: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
        if storageManger.authId() == "nouserName"{
            self.userNameLabel.text = "Please Login"
        }
        else{
            shared.loginViewModel.getUserName(authId: storageManger.authId()) {
                DispatchQueue.main.async {
                    print("coming")
                    self.userNameLabel.text = self.shared.loginViewModel.user?.capitalized
                }
            } fail: { () in
                print("fail")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        UINib(nibName: "SuggestionsTopView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(view)
        view.frame = self.bounds
        initCollectionView()
        userNameLabel.text = shared.loginUserName?.capitalized
        
        if storageManger.authId() == "nouserName"{
            self.userNameLabel.text = "Please Login"
        }
        else{
            shared.loginViewModel.getUserName(authId: storageManger.authId()) {
                DispatchQueue.main.async {
                    print("coming")
                    self.userNameLabel.text = self.shared.loginViewModel.user?.capitalized
                }
            } fail: { () in
                print("fail")
            }
        }
    }
}


extension SuggestionsTopView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("bannerCount",bannerImage.count)
        return bannerImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = suggestionsCollectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCell", for: indexPath) as? SuggestionsCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        
        let url = URL(string: bannerImage[indexPath.row])
        let data = try? Data(contentsOf: url!)
        //cell.courseImage.image = UIImage(data: data!)
        cell.cellImage.image = UIImage(data: data!)
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
    
    func returnObj() -> UIView {
        
        return view
    }
    
}
