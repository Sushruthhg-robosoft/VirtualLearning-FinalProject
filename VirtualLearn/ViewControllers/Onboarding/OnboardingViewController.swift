//
//  ViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 06/12/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    var storageMaaneger = StorageManeger()
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1{
                nextBtn.setImage(#imageLiteral(resourceName: "btn_done"), for: .normal)
            }else{
                
                nextBtn.setImage(#imageLiteral(resourceName: "btn_next"), for: .normal)
            }
        }
    }
    
    
    var slides: [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageMaaneger.setOnboardingseen()
        
        navigationController?.navigationBar.isHidden = true
        
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        slides = [OnboardingSlide(title: "Learner Engagement", onboardingDescription: "Interactive features mirror the traditional classroom experience and learners receive feedback to increase long-term retention, tripling learning efficacy over standard video.", onboardingImage: #imageLiteral(resourceName: "img_onboarding_illustration1")) , OnboardingSlide(title: "Accountable Tracking", onboardingDescription: "Receive immediate, accessible data (both performance and behavior-based) to effectively remediate concepts, automatically assign grades, and address deficiencies.", onboardingImage: #imageLiteral(resourceName: "img_onboarding_illustration2")), OnboardingSlide(title: "Seamless Workflow", onboardingDescription: "Sync rosters, create and assign impactful video experiences, enrich your flipped classroom, and streamline tedious grading.", onboardingImage: #imageLiteral(resourceName: "img_onboarding_illustration3"))]
        
        pageControl.transform = CGAffineTransform(scaleX: 1, y: 1)
        
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        
        
        if currentPage == slides.count - 1 {
            
            let vc = storyboard?.instantiateViewController(identifier: "LandingViewController") as! LandingViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            currentPage += 1
            pageControl.currentPage = currentPage
            
            
            self.onboardingCollectionView.contentOffset.x += onboardingCollectionView.frame.width
            
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
                
            }, completion: nil)
        }
        
    }
    
    @IBAction func onClickSkip(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LandingViewController") as! LandingViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func pageControl(_ sender: Any) {
    }
    
    
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let noOfCellsInRow = 1   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        return CGSize(width: onboardingCollectionView.frame.width , height: onboardingCollectionView.frame.height)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: nil) { (context) -> Void in
            self.onboardingCollectionView.reloadData()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
        
        
    }
}

