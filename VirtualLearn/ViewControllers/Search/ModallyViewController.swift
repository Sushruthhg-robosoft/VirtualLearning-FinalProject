//
//  ModallyViewController.swift
//  SearchScreen
//
//  Created by Santhosh Patkar on 13/12/22.
//

import UIKit

class ModallyViewController: UIViewController {
    
    let shared = mainViewModel.mainShared
    
    var searchField = ""
    
    
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
    
    
    
    
    let duration1 = ["stratDuration" : 5, "EndDuration" : 10]
    let duration2 = ["stratDuration" : 10, "EndDuration" : 20]
    let duration3 = ["stratDuration" : 20, "EndDuration" : 30]
    let duration4 = ["stratDuration" : 30, "EndDuration" : 40]
    let duration5 = ["stratDuration" : 40, "EndDuration" : 50]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickDesign(_ sender: Any) {
        
        if isdesign{
            designBtn.selected()
            getCategoryID(currentTitle: designBtn.currentTitle ?? "")
            isdesign = !isdesign
        }
        else if !isdesign{
            designBtn.deselected()
            let id = returnCategoryID(currentTitle: designBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}

            isdesign = !isdesign
        }
        
    }
    
    @IBAction func onClickDevelopment(_ sender: Any) {
        if isdevelopment{
            developmentBtn.selected()
            getCategoryID(currentTitle: developmentBtn.currentTitle ?? "")
            isdevelopment = !isdevelopment
        }
        else if !isdevelopment{
            developmentBtn.deselected()
            let id = returnCategoryID(currentTitle: developmentBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isdevelopment = !isdevelopment
        }
    }
    
    @IBAction func onClickBusiness(_ sender: Any) {
        if isbusiness{
            businessBtn.selected()
            getCategoryID(currentTitle: businessBtn.currentTitle ?? "")
            isbusiness = !isbusiness
        }
        else if !isbusiness{
            businessBtn.deselected()
            let id = returnCategoryID(currentTitle: businessBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isbusiness = !isbusiness
        }
    }
    
    @IBAction func onClickFinance(_ sender: Any) {
        if isfinance{
            financeBtn.selected()
            getCategoryID(currentTitle: financeBtn.currentTitle ?? "")
            isfinance = !isfinance
        }
        else if !isfinance{
            financeBtn.deselected()
            let id = returnCategoryID(currentTitle: financeBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isfinance = !isfinance
        }
    }
    
    @IBAction func onClickHealthFitness(_ sender: Any) {
        if ishealth{
            healthFitnessBtn.selected()
            getCategoryID(currentTitle: healthFitnessBtn.currentTitle ?? "")
            ishealth = !ishealth
        }
        else if !ishealth{
            healthFitnessBtn.deselected()
            let id = returnCategoryID(currentTitle: healthFitnessBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            ishealth = !ishealth
        }
    }
    
    @IBAction func onClickMusic(_ sender: Any) {
        if ismusic{
            musicBtn.selected()
            getCategoryID(currentTitle: musicBtn.currentTitle ?? "")
            ismusic = !ismusic
        }
        else if !ismusic{
            musicBtn.deselected()
            let id = returnCategoryID(currentTitle: musicBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            ismusic = !ismusic
        }
    }
    
    @IBAction func onClickIT(_ sender: Any) {
        if isIT{
            ITBtn.selected()
            getCategoryID(currentTitle: ITBtn.currentTitle ?? "")
            isIT = !isIT
        }
        else if !isIT{
            ITBtn.deselected()
            let id = returnCategoryID(currentTitle: ITBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isIT = !isIT
        }
    }
    
    @IBAction func onClickMarketing(_ sender: Any) {
        if ismarketing{
            marketingBtn.selected()
            getCategoryID(currentTitle: marketingBtn.currentTitle ?? "")
            ismarketing = !ismarketing
        }
        else if !ismarketing{
            marketingBtn.deselected()
            let id = returnCategoryID(currentTitle: marketingBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            ismarketing = !ismarketing
        }
    }
    
    @IBAction func onClickLifestyle(_ sender: Any) {
        if islifestyle{
            lifeStyleBtn.selected()
            getCategoryID(currentTitle: lifeStyleBtn.currentTitle ?? "")
            islifestyle = !islifestyle
        }
        else if !islifestyle{
            lifeStyleBtn.deselected()
            let id = returnCategoryID(currentTitle: lifeStyleBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            islifestyle = !islifestyle
        }
    }
    
    @IBAction func onClickPhotography(_ sender: Any) {
        if isphotography{
            PhotographyBtn.selected()
            getCategoryID(currentTitle: PhotographyBtn.currentTitle ?? "")
            isphotography = !isphotography
        }
        else if !isphotography{
            PhotographyBtn.deselected()
            let id = returnCategoryID(currentTitle: PhotographyBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isphotography = !isphotography
        }
    }
    
    @IBAction func onClickTeaching(_ sender: Any) {
        if isteaching{
            teachingBtn.selected()
            getCategoryID(currentTitle: teachingBtn.currentTitle ?? "")
            isteaching = !isteaching
        }
        else if !isteaching{
            teachingBtn.deselected()
            let id = returnCategoryID(currentTitle: teachingBtn.currentTitle ?? "")
            shared.searchViewModelShared.categories = shared.searchViewModelShared.categories.filter{$0 != id}
            isteaching = !isteaching
        }
    }
    
    @IBAction func onClickFiveTen(_ sender: Any) {
        if isFiveTen{
            fiveTenBtn.selected()
            shared.searchViewModelShared.duration.append(duration1)
            isFiveTen = !isFiveTen
        }
        else if !isFiveTen{
            fiveTenBtn.deselected()
            shared.searchViewModelShared.duration = shared.searchViewModelShared.duration.filter{$0 != duration1}
            isFiveTen = !isFiveTen
        }
    }
    
    @IBAction func onClickTenTwenty(_ sender: Any) {
        if isTenTwenty{
            tenTwentyBtn.selected()
            shared.searchViewModelShared.duration.append(duration2)
            isTenTwenty = !isTenTwenty
        }
        else if !isTenTwenty{
            tenTwentyBtn.deselected()
            shared.searchViewModelShared.duration = shared.searchViewModelShared.duration.filter{$0 != duration2}
            isTenTwenty = !isTenTwenty
        }
    }
    
    @IBAction func onClickTwentyThirty(_ sender: Any) {
        if isTwentyThirty{
            twentyThirtyBtn.selected()
            shared.searchViewModelShared.duration.append(duration3)
            isTwentyThirty = !isTwentyThirty
        }
        else if !isTwentyThirty{
            twentyThirtyBtn.deselected()
            shared.searchViewModelShared.duration = shared.searchViewModelShared.duration.filter{$0 != duration3}
            isTwentyThirty = !isTwentyThirty
        }
    }
    
    @IBAction func onClickThirtyFourty(_ sender: Any) {
        if isThirtyFourty{
            thirtyFourtyBtn.selected()
            shared.searchViewModelShared.duration.append(duration4)
            isThirtyFourty = !isThirtyFourty
        }
        else if !isThirtyFourty{
            thirtyFourtyBtn.deselected()
            shared.searchViewModelShared.duration = shared.searchViewModelShared.duration.filter{$0 != duration4}
            isThirtyFourty = !isThirtyFourty
        }
    }
    
    
    @IBAction func onClickFourtyFifty(_ sender: Any) {
        if isFourtyFifty{
            fourtyFiftyBtn.selected()
            shared.searchViewModelShared.duration.append(duration5)
            isFourtyFifty = !isFourtyFifty
        }
        else if !isFourtyFifty{
            fourtyFiftyBtn.deselected()
            shared.searchViewModelShared.duration = shared.searchViewModelShared.duration.filter{$0 != duration5}
            isFourtyFifty = !isFourtyFifty
        }
    }
    
    
    @IBAction func onClickApplyFilter(_ sender: Any) {
        shared.searchViewModelShared.searchOption = searchField
        shared.searchViewModelShared.getSearchResult { (result) in
            print(result)
        } fail: { (fail) in
            print(fail)
        }
        shared.searchViewModelShared.duration.removeAll()
        shared.searchViewModelShared.categories.removeAll()
        dismiss(animated: true, completion: nil)

        
    }
    
    
    @IBAction func onClickClearAll(_ sender: Any) {
        
        designBtn.deselected()
        developmentBtn.deselected()
        businessBtn.deselected()
        financeBtn.deselected()
        healthFitnessBtn.deselected()
        musicBtn.deselected()
        ITBtn.deselected()
        marketingBtn.deselected()
        lifeStyleBtn.deselected()
        PhotographyBtn.deselected()
        teachingBtn.deselected()
        
        fiveTenBtn.deselected()
        tenTwentyBtn.deselected()
        twentyThirtyBtn.deselected()
        thirtyFourtyBtn.deselected()
        fourtyFiftyBtn.deselected()
        
 
    }
    
    
    
    
    func getCategoryID(currentTitle: String){
        print("function called")
        for i in shared.categoriesViewModelShared.listofCategories{
            if currentTitle == i.categotyName {
                shared.searchViewModelShared.categories.append(Int(i.categoryId) ?? 0)
            }
        }
    }
    func returnCategoryID(currentTitle: String) -> Int{
        var temp = 0
        for i in shared.categoriesViewModelShared.listofCategories{
            if currentTitle == i.categotyName {
                temp = Int(i.categoryId) ?? 0
            }
        }
        return temp
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
