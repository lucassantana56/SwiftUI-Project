//
//  Keychain.swift
//  mywords
//
//  Created by Lucas Santana on 01/02/2021.
//

import Foundation

let StrUsernameKey:String = "username"
let StrUserIDKey:String = "userid"

class Keychain {
    func setPasscode(id: String,passcode: String) {
        let keychainAccess = KeychainAccess();
        keychainAccess.setPasscode(identifier:id, passcode:passcode);
    }
    
    
    func getPasscode(id: String) -> NSString {
        let keychainAccess = KeychainAccess();
        return keychainAccess.getPasscode(identifier: id)! as NSString;
    }
    
    func deletePasscode(id: String) {
        let keychainAccess = KeychainAccess();
        keychainAccess.setPasscode(identifier:id, passcode:"");
    }
}
