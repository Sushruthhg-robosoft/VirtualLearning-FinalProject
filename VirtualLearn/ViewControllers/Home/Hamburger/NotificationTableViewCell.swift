//
//  NotificationTableViewCell.swift
//  VirtualLearn
//
//  Created by Manish R T on 13/12/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notification: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seenView: UIView!
    
    var isSeen: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        //setSeenView()
    }
    
    func setSeenView(){
        
        if isSeen{
            seenView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9647058824, blue: 0.9843137255, alpha: 1)
            notification.font = UIFont.boldSystemFont(ofSize: 14)
        }
        else{
            seenView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            
        }
    }

}
