//
//  ViewController.swift
//  TestResultScreen
//
//  Created by Sushruth H G on 13/12/22.
//

import UIKit

class TestResultViewController: UIViewController {

    @IBOutlet weak var middleLeftView: UIView!
    
    @IBOutlet weak var middleRightView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var middleView: UIView!
    let testviewModel = ModuleTestViewModel()
    let mainShared = mainViewModel.mainShared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        testviewModel.getAnswer(token: mainShared.token, assignnmentId: "5") {
            print("sucess")
        } fail: {
            print("error")
        }

        middleLeftView.layer.cornerRadius = 5
        middleRightView.layer.cornerRadius = 5
       
        middleView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        middleView.layer.shadowOpacity = 100
        middleView.layer.shadowRadius = 5
        middleView.layer.shadowOffset = CGSize(width: 0, height: 2)
        tableView.delegate = self
        tableView.dataSource = self
    }


}


extension TestResultViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuestionListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "showQuestionResultViewController") as! showQuestionResultViewController
        
        present(vc, animated: true, completion: nil)
    }
    
    
}


