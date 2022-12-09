//
//  ViewController.swift
//  VLMyCourseVc
//
//  Created by Sushruth H G on 08/12/22.
//

import UIKit

class MyCourseViewController: UIViewController {
    
    

    @IBOutlet weak var ongoingBtn: UIButton!
    
    @IBOutlet weak var completedBtn: UIButton!
    
    @IBOutlet weak var newUserContainerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var isNewUser: Bool = false
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        newUserContainerView.isHidden = true
        super.viewDidLoad()


    }

    
    @IBAction func onClickOngoingBtn(_ sender: Any) {
        completedBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        completedBtn.setTitleColor(#colorLiteral(red: 0.5518978834, green: 0.5519112945, blue: 0.5519040227, alpha: 1), for: .normal)
        ongoingBtn.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        ongoingBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    @IBAction func onClickCompletedBtn(_ sender: Any) {
        
       
        
        completedBtn.backgroundColor = #colorLiteral(red: 0.001148699783, green: 0.2356859446, blue: 0.4366979599, alpha: 1)
        completedBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        ongoingBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ongoingBtn.setTitleColor(#colorLiteral(red: 0.5518978834, green: 0.5519112945, blue: 0.5519040227, alpha: 1), for: .normal)
    }
    
    @IBAction func onClickBurger(_ sender: Any) {
        
        
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        
        
    }
    
    
    
    
}

extension MyCourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCourseTableViewCell
        
        
        return cell
    }
    
    
}

