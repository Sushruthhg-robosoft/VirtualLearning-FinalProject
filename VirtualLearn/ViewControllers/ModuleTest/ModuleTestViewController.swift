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
    var testAnswers: [Int:String] = [:]
    var questionNo = 0
    
    var moduleTestViewModel = ModuleTestViewModel()
    let mainShared = mainViewModel.mainShared
    var time = ""
    var assignmentId = ""
    
    var currentPage = 0 {
        didSet {
            if currentPage == moduleTestViewModel.moduleTestData.count - 1{
                nextButton.isHidden = true
                submitButton.isHidden = false
            
            }else{
                nextButton.isHidden = false
                submitButton.isHidden = true
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isHidden = false
        submitButton.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        previousButton.isEnabled = false
        moduleTestViewModel.getQuestions(limit: "3", page: "1", assignnmentId: assignmentId) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.timerCountdown()
                
            }
        } fail: {error in
            
            // self.stopLoader(loader: loader)
            print("failures")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    //                    self.navigationController?.popViewController(animated: true)
                }
            }
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
    
    @IBAction func onclickSubmit(_ sender: Any) {
        moduleTestViewModel.submitAnswer(token: mainShared.token, assignnmentId: "5", testAnswers: testAnswers){
            
            print("sucess")
            DispatchQueue.main.async {
                guard let vc = self.storyboard?.instantiateViewController(identifier: "CongratsViewController") as? CongratsViewController else {return}
                self.navigationController?.pushViewController(vc, animated: true)
                vc.assignmentId = self.assignmentId
            }
        } fail: {error in
        
            print("failures")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    //                   self.navigationController?.popViewController(animated: true)
                }
            }
            
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
//        cell?.questionNoLabel.text = moduleTestViewModel.moduleTestData[indexPath.row].questionId
        cell?.QuestionInd = Int(moduleTestViewModel.moduleTestData[indexPath.row].questionId)
        cell?.delegate = self
        cell?.option1Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_1
        cell?.option2Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_2
        cell?.option3Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_3
        cell?.option4Label.text = moduleTestViewModel.moduleTestData[indexPath.row].option_4
        cell?.questionNoLabel.text = "Question \(indexPath.row + 1) of \(moduleTestViewModel.moduleTestData.count) remaining"
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

extension ModuleTestViewController: saveAnswers{
    func save(QuestionID: Int, Answer: String) {
        self.testAnswers[QuestionID] = Answer
    }
    
    
}

