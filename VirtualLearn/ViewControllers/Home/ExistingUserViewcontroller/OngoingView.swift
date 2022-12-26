//
//  OngoingView.swift
//  VirtualLearn
//
//  Created by Manish R T on 14/12/22.
//

import UIKit

class OngoingView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
  
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet weak var ongoingCollectionView: UICollectionView!
    var mainShared = mainViewModel.mainShared
    var shared = ViewModel.shared

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        UINib(nibName: "OngoingView", bundle: nil).instantiate(withOwner: self, options: nil)
        addSubview(backView)
        backView.frame = self.bounds
        initCollectionView()
        
        mainShared.myCourseViewModelShared.getMycourseDetails(token: mainShared.token) {
            DispatchQueue.main.async {
                self.ongoingCollectionView.reloadData()
            }
            
        } fail: { error in
            print("ongoing home fail")
        }

        
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: "ExistingCollectionViewCell", bundle: nil)
        ongoingCollectionView.register(nib, forCellWithReuseIdentifier: "existingUserCell")
        ongoingCollectionView.dataSource = self
        ongoingCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainShared.myCourseViewModelShared.ongoingCourses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = ongoingCollectionView.dequeueReusableCell(withReuseIdentifier: "existingUserCell", for: indexPath) as? ExistingCollectionViewCell else {
            fatalError("can't dequeue CustomCell")
            
        }
        cell.ChapterName.text = mainShared.myCourseViewModelShared.ongoingCourses[indexPath.row].courseName
        cell.numberOfChapters.text = "\(mainShared.myCourseViewModelShared.ongoingCourses[indexPath.row].completedCount) /\(mainShared.myCourseViewModelShared.ongoingCourses[indexPath.row].totalNumberOfChapters) Chapters"
        let url = URL(string: mainShared.myCourseViewModelShared.ongoingCourses[indexPath.row].courseImage)
        let data = try? Data(contentsOf: url!)
        cell.ongoingImage.image = UIImage(data: data!)
        cell.Index = indexPath
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shared.delegate?.onClickChoiceofYourCourse(courseId: mainShared.homeViewModelShared.allCourse[indexPath.row].courseId)

    }
}

extension OngoingView: CourseContinue {
    func continueCourse(indexPath: IndexPath) {
        shared.delegate?.onClickChoiceofYourCourse(courseId: mainShared.homeViewModelShared.allCourse[indexPath.row].courseId)
    }
    
    
}
