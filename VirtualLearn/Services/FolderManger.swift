//
//  FolderManger.swift
//  VirtualLearn
//
//  Created by Manish R T on 21/12/22.
//

import Foundation
class StorageManeger{
     
    static var  shared = StorageManeger()
    enum key: String {
        case onbordingSeen
        case HomeViewModelSeen
    }
    
    enum loggingKey: String, CaseIterable{
        
        case loggedIn
        case userID
    }
    
    func isOnboardingSeen() -> Bool{
        
        UserDefaults.standard.bool(forKey: key.onbordingSeen.rawValue)
    }
    func authId() -> String{
        
        UserDefaults.standard.string(forKey: loggingKey.userID.rawValue)!
    }
    
    func setOnboardingseen(){
        UserDefaults.standard.setValue(true, forKey: key.onbordingSeen.rawValue)
    }
    
    func resetOnboardingseen(){
        UserDefaults.standard.setValue(false, forKey: key.onbordingSeen.rawValue)
    }
    
    func isLoggedIn() -> Bool{
        
        UserDefaults.standard.bool(forKey: loggingKey.loggedIn.rawValue)
       
    }
    
    func setLoggedIn(){
        
        UserDefaults.standard.setValue(true, forKey: loggingKey.loggedIn.rawValue)
        
    }
    func resetLoggedIn(){
        
        UserDefaults.standard.setValue(false, forKey: loggingKey.loggedIn.rawValue)
    }
    
    func setUsernameData(useriD: String){
        
        UserDefaults.standard.setValue(useriD, forKey: loggingKey.userID.rawValue)
        
    }
    
    func setGuestUser(){
        
        UserDefaults.standard.setValue("nouserName", forKey: loggingKey.userID.rawValue)
    }
    
    
}
