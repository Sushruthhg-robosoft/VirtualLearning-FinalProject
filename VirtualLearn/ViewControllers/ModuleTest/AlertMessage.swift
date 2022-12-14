//
//  AlertMessage.swift
//  ModuleTestScreens
//
//  Created by Anushree J C on 12/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertforCancel(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancel: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if handlerCancel != nil {
            let action = UIAlertAction(title: "Quit", style: .destructive, handler: handlerOK)
            let (actionCancel) = UIAlertAction(title: "Cancel", style: .cancel, handler: handlerCancel)
            alert.addAction(actionCancel)
            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "Quit", style: .default, handler: handlerOK)
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertforSubmit(title: String, message: String, handlerOK:((UIAlertAction) -> Void)?, handlerCancel: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if handlerCancel != nil {
            let action = UIAlertAction(title: "Submit", style: .destructive, handler: handlerOK)
            let (actionCancel) = UIAlertAction(title: "Cancel", style: .cancel, handler: handlerCancel)
            alert.addAction(actionCancel)
            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "Submit", style: .default, handler: handlerOK)
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
//    func alertAction(controller: UIViewController, message: String) {
//        let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: nil))
//        controller.present(alert, animated: true, completion: nil)
//    }
}

