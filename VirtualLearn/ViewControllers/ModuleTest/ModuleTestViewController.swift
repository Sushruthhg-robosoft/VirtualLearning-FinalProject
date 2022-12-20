//
//  ViewController.swift
//  ModuleTestScreens
//
//  Created by Anushree J C on 12/12/22.
//

import UIKit

class ModuleTestViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!

    var moduleTestViewModel = ModuleTestViewModel()
    var time = ""

    var currentPage = 0 {
        didSet {
            if currentPage == moduleTestViewModel.moduleTestData.count - 1{
                nextButton.isHidden = true
                submitButton.isHidden = false
                //  nextButton.isHidden = false
                //  submitButton.isHidden = true
            }else{
                nextButton.isHidden = false
                submitButton.isHidden = true
                
                //  nextButton.isHidden = true
                //  submitButton.isHidden = false
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timerCountdown()
        
        nextButton.isHidden = false
        submitButton.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        previousButton.isEnabled = false
        moduleTestViewModel.getQuestions(limit: "3", page: "1", assignnmentId: "5") {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } fail: {
            print("fail")
        }

        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        previousButton.isEnabled = true
        
        
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)

        if nextItem.row < moduleTestViewModel.moduleTestData.count {
            
            self.collectionView.scrollToItem(at: nextItem, at: .right, animated: true)
            
        }
        if nextItem.row == moduleTestViewModel.moduleTestData.count - 1{
            print(nextItem.row)
            submitButton.isHidden = false
            nextButton.isHidden = true
        }
        
        
        
    }
    
    
    @IBAction func onClickPrevious(_ sender: Any) {
        
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        // This part here
        if nextItem.row < moduleTestViewModel.moduleTestData.count {
            previousButton.isEnabled = true
            submitButton.isHidden = true
            nextButton.isHidden = false
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
            if nextItem.row == 0{
                previousButton.isEnabled = false
            }
          
        }
     
    }
    
    
    @IBAction func onClickCancelBtn(_ sender: Any) {
        showAlertforCancel(title: "Alert", message: "Are you sure you want to quit the exam?") { action in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            
        } handlerCancel: { actionCancel in
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func timerCountdown(){
        var remainingTime = 60 * 10
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            remainingTime -= 1
            
            if remainingTime <= 0 {
                timer.invalidate()
            }
            
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            self.time = String(format: "%02d:%02d", minutes, seconds)
            self.timeLabel.text = self.time
            
        }
    }
}

extension ModuleTestViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moduleTestViewModel.moduleTestData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ModuleTestCollectionViewCell
        cell?.question.text = moduleTestViewModel.moduleTestData[indexPath.row].questionName
        cell?.questionNoLabel.text = moduleTestViewModel.moduleTestData[indexPath.row].questionId
        cell?.option1Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_1
        cell?.option2Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_2
        cell?.option3Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_3
        cell?.option4Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_4
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 1   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = (collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)
        
        return CGSize(width: size, height: size)
        
    }
}

