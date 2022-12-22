//
//  KeyChain.swift
//  VirtualLearn
//
//  Created by Santhosh Patkar on 11/12/22.
//

import Foundation

class KeyChain {
    var shared = mainViewModel.mainShared
    func saveData(userId: String, data: Data)  {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecValueData as String   : data ] as [String : Any]
        
        _ = SecItemAdd(query as CFDictionary, nil)
        
    }
    
    func loadData(userId: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
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
    
    
    func deletePassword(userId: String, data: Data) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : userId,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String: Any]

        let status = SecItemDelete(query as CFDictionary)
        print(status)
        // Any status other than errSecSuccess indicates the
        // delete operation failed.
        shared.token = ""
        shared.isExisting = false
        print("deleted successfully", shared.token)
        
    }
}
