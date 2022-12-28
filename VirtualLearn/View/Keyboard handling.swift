//
//  Keyboard handling.swift
//  VirtualLearn
//
//  Created by Anushree J C on 28/12/22.
//

import Foundation
import UIKit

extension ChangeYourPasswordViewController {
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
    
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        
        view.endEditing(true)
    }
}
    
extension EditProfileViewController {
    func initializeHideKeyboard(){

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))


        view.addGestureRecognizer(tap)
    }

    @objc func dismissMyKeyboard(){

        view.endEditing(true)
    }
}

extension 
func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        
        view.endEditing(true)
    }
    
}


    

