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
    
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let loader =   self.loader()
        shared.notificationViewModelShared.getNotificationCount {
            self.tableview.reloadData()
        } fail: {
        }

        
        shared.notificationViewModelShared.getNotifications(limit: "5", page: "1") {
            DispatchQueue.main.async {
                self.stopLoader(loader: loader)
                self.tableview.reloadData()
            }
            
        } fail: {
            self.stopLoader(loader: loader)
            self.okAlertMessagePopup(message: "Failed to load notification")
            print("fail")
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(shared.notifications.count)
        return shared.notificationViewModelShared.notifications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as? NotificationTableViewCell
        cell?.notification.text = shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).notificationMessage
        let url = URL(string: shared.notificationViewModelShared.fetchDataToNotificationCell(index: indexPath.row).notificationImage)
        let data = try? Data(contentsOf: url!)
        cell?.notificationImage.image = UIImage(data: data!)
        return cell!
    }
}
