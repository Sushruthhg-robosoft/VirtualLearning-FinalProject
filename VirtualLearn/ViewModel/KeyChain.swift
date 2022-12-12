//
//  KeyChain.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 11/12/22.
//

import Foundation

class KeyChain {
    
    func saveData(userName: String, data: Data)  {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userName,
            kSecValueData as String   : data ] as [String : Any]
        
        _ = SecItemAdd(query as CFDictionary, nil)
        
    }
    
    func loadData(userName: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userName,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String: Any]
        
        var result: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
        if status == noErr {
            return result as! Data?
        } else {
            return nil
        }
    }
}
