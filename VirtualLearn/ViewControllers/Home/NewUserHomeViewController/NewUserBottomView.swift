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
}

class NewUserBottomView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    

    @IBOutlet var backView: UIView!
    @IBOutlet weak var allBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var popularBtn: ChoiceOfCourseCustomButton!
    @IBOutlet weak var newestBtn: ChoiceOfCourseCustomButton!
    


    @IBOutlet weak var choiceOfUrCourseCollectionView: UICollectionView!
    
    @IBOutlet weak var topCourse1Label: UILabel!
    @IBOutlet weak var topCourse1CollectionView: UICollectionView!

    @IBOutlet weak var topCourse1: TopCourseSectionView!
    @IBOutlet weak var topCourse2: TopCourseSectionView!
    
    
    var courseSet: [UIImage] = [#imageLiteral(resourceName: "img_course1_bg"), #imageLiteral(resourceName: "img_course2_bg")]
    var delegate: clickButtons?
    var shared = ViewModel.shared
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
       // topCourse2.topCourseTitle.text = "Top courses in Design"
        topCourse2.topCourseLabel.text = "Top courses in Design"
        
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
    }
    
    @IBAction func onClickPopular(_ sender: Any) {
        
        allBtn.notSelected()
        popularBtn.isSelected()
        newestBtn.notSelected()
    }
    
    @IBAction func onClickNewest(_ sender: Any) {
        
        allBtn.notSelected()
        popularBtn.notSelected()
        newestBtn.isSelected()
    }
    private func initCollectionView() {
        let nib = UINib(nibName: "ChoiceOfYourCourseCollectionViewCell", bundle: nil)
        choiceOfUrCourseCollectionView.register(nib, forCellWithReuseIdentifier: "choiceCell")
        choiceOfUrCourseCollectionView.dataSource = self
        choiceOfUrCourseCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = choiceOfUrCourseCollectionView.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as? ChoiceOfYourCourseCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
            
        }
        
        
        
        //cell.lessonImage.image = courseSet[indexPath.row]
        //topCourseView2.topCourseTitle.text = "Top courses in Design"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shared.delegate?.onClickChoiceofYourCourse()
    }
    

    
}



