//
//  NotificationViewController.swift
//  VirtualLearn
//
//  Created by Manish R T on 13/12/22.
//

import UIKit


class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var shared = mainViewModel.mainShared
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loader =   self.loader()
        shared.notificationViewModelShared.getNotifications(token: shared.token , limit: "30", page: "1") {
            
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.tableview.reloadData()
            }
            
        } fail: { error in
            
            self.stopLoader(loader: loader)
            self.okAlertMessagePopup(message: "Failed to load notification")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shared.notificationViewModelShared.notifications.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as? NotificationTableViewCell
        cell?.notification.text = shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).notificationMessage
        let url = URL(string: shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).notificationImage)
        let data = try? Data(contentsOf: url!)
        cell?.notificationImage.image = UIImage(data: data!)
        
        if shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).readStatus{
            cell?.seenView.isHidden = true
            cell?.backGroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            cell?.seenView.isHidden = false
            cell?.backGroundView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9647058824, blue: 0.9843137255, alpha: 1)
        }
        
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        shared.notificationViewModelShared.readNotification(token: shared.token, notificationId: shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).id) { (data) in
            
            DispatchQueue.main.async {
                if data == "true"{
                    if let cell = tableView.cellForRow(at: indexPath) as? NotificationTableViewCell {
                        print("asfsedfsdf")
                        cell.seenView.isHidden = true
                        cell.backGroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        //cell.contentView.backgroundColor = .black
                    }
                }
            }
            
        } fail: {  error in
            
            
            self.okAlertMessagePopup(message: "Failed to load notification")
            print("failures")
            DispatchQueue.main.async {
                if(error == "unauthorized") {
                    
                }
                else {
                    
                }
            }
        }
        
        
        
    }
}
