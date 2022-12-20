//
//  ModallyViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 13/12/22.
//

import UIKit

class ModallyViewController: UIViewController {
    
    
    @IBOutlet weak var designBtn: CustomBorderButton!
    @IBOutlet weak var developmentBtn: CustomBorderButton!
    @IBOutlet weak var businessBtn: CustomBorderButton!
    @IBOutlet weak var financeBtn: CustomBorderButton!
    @IBOutlet weak var healthFitnessBtn: CustomBorderButton!
    @IBOutlet weak var musicBtn: CustomBorderButton!
    @IBOutlet weak var ITBtn: CustomBorderButton!
    @IBOutlet weak var marketingBtn: CustomBorderButton!
    @IBOutlet weak var lifeStyleBtn: CustomBorderButton!
    @IBOutlet weak var PhotographyBtn: CustomBorderButton!
    @IBOutlet weak var teachingBtn: CustomBorderButton!
    
    

    
    var isdesign = true
    var isdevelopment = true
    var isbusiness = true
    var isfinance = true
    var ishealth = true
    var ismusic = true
    var isIT = true
    var ismarketing = true
    var islifestyle = true
    var isphotography = true
    var isteaching = true
    
    var isFiveTen = true
    var isTenTwenty = true
    var isTwentyThirty = true
    var isThirtyFourty = true
    var isFourtyFifty = true

    
    
    
    @IBOutlet weak var fiveTenBtn: CustomBorderButton!
    @IBOutlet weak var tenTwentyBtn: CustomBorderButton!
    @IBOutlet weak var twentyThirtyBtn: CustomBorderButton!
    @IBOutlet weak var thirtyFourtyBtn: CustomBorderButton!
    @IBOutlet weak var fourtyFiftyBtn: CustomBorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickDesign(_ sender: Any) {
        
        if isdesign{
            designBtn.selected()
            isdesign = !isdesign
        }
        else if !isdesign{
            designBtn.deselected()
            isdesign = !isdesign
        }
        
    }
    
    @IBAction func onClickDevelopment(_ sender: Any) {
        if isdevelopment{
            developmentBtn.selected()
            isdevelopment = !isdevelopment
        }
        else if !isdevelopment{
            developmentBtn.deselected()
            isdevelopment = !isdevelopment
        }
    }
    
    @IBAction func onClickBusiness(_ sender: Any) {
        if isbusiness{
            businessBtn.selected()
            isbusiness = !isbusiness
        }
        else if !isbusiness{
            businessBtn.deselected()
            isbusiness = !isbusiness
        }
    }
    
    @IBAction func onClickFinance(_ sender: Any) {
        if isfinance{
            financeBtn.selected()
            isfinance = !isfinance
        }
        else if !isfinance{
            financeBtn.deselected()
            isfinance = !isfinance
        }
    }
    
    @IBAction func onClickHealthFitness(_ sender: Any) {
        if ishealth{
            healthFitnessBtn.selected()
            ishealth = !ishealth
        }
        else if !ishealth{
            healthFitnessBtn.deselected()
            ishealth = !ishealth
        }
    }
    
    @IBAction func onClickMusic(_ sender: Any) {
        if ismusic{
            musicBtn.selected()
            ismusic = !ismusic
        }
        else if !ismusic{
            musicBtn.deselected()
            ismusic = !ismusic
        }
    }
    
    @IBAction func onClickIT(_ sender: Any) {
        if isIT{
            ITBtn.selected()
            isIT = !isIT
        }
        else if !isIT{
            ITBtn.deselected()
            isIT = !isIT
        }
    }
    
    @IBAction func onClickMarketing(_ sender: Any) {
        if ismarketing{
            marketingBtn.selected()
            ismarketing = !ismarketing
        }
        else if !ismarketing{
            marketingBtn.deselected()
            ismarketing = !ismarketing
        }
    }
    
    @IBAction func onClickLifestyle(_ sender: Any) {
        if islifestyle{
            lifeStyleBtn.selected()
            islifestyle = !islifestyle
        }
        else if !islifestyle{
            lifeStyleBtn.deselected()
            islifestyle = !islifestyle
        }
    }
    
    @IBAction func onClickPhotography(_ sender: Any) {
        if isphotography{
            PhotographyBtn.selected()
            isphotography = !isphotography
        }
        else if !isphotography{
            PhotographyBtn.deselected()
            isphotography = !isphotography
        }
    }
    
    @IBAction func onClickTeaching(_ sender: Any) {
        if isteaching{
            teachingBtn.selected()
            isteaching = !isteaching
        }
        else if !isteaching{
            teachingBtn.deselected()
            isteaching = !isteaching
        }
    }
    
    @IBAction func onClickFiveTen(_ sender: Any) {
        if isFiveTen{
            fiveTenBtn.selected()
            isFiveTen = !isFiveTen
        }
        else if !isFiveTen{
            fiveTenBtn.deselected()
            isFiveTen = !isFiveTen
        }
    }
    
    @IBAction func onClickTenTwenty(_ sender: Any) {
        if isTenTwenty{
            tenTwentyBtn.selected()
            isTenTwenty = !isTenTwenty
        }
        else if !isTenTwenty{
            tenTwentyBtn.deselected()
            isTenTwenty = !isTenTwenty
        }
    }
    
    @IBAction func onClickTwentyThirty(_ sender: Any) {
        if isTwentyThirty{
            twentyThirtyBtn.selected()
            isTwentyThirty = !isTwentyThirty
        }
        else if !isTwentyThirty{
            twentyThirtyBtn.deselected()
            isTwentyThirty = !isTwentyThirty
        }
    }
    
    @IBAction func onClickThirtyFourty(_ sender: Any) {
        if isThirtyFourty{
            thirtyFourtyBtn.selected()
            isThirtyFourty = !isThirtyFourty
        }
        else if !isThirtyFourty{
            thirtyFourtyBtn.deselected()
            isThirtyFourty = !isThirtyFourty
        }
    }
    
    
    @IBAction func onClickFourtyFifty(_ sender: Any) {
        if isFourtyFifty{
            fourtyFiftyBtn.selected()
            isFourtyFifty = !isFourtyFifty
        }
        else if !isFourtyFifty{
            fourtyFiftyBtn.deselected()
            isFourtyFifty = !isFourtyFifty
        }
    }
    
    
    
    
}

extension UIButton {
    
    func selected(){
        
        self.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7450980392, blue: 0.2941176471, alpha: 1)
        
    }
    
    func deselected(){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
}
