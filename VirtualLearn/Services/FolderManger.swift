//
//  FolderManger.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import Foundation
class StorageManeger{
     
    enum key: String {
        case onbordingSeen
        case HomeViewModelSeen
    }
    func isOnboardingSeen() -> Bool{
        
        UserDefaults.standard.bool(forKey: key.onbordingSeen.rawValue)
    }
    
    func setOnboardingseen(){
        UserDefaults.standard.setValue(true, forKey: key.onbordingSeen.rawValue)
    }
    
    func resetOnboardingseen(){
        UserDefaults.standard.setValue(false, forKey: key.onbordingSeen.rawValue)
    }
}
