//
//  Credential.swift
//  MymoUpload
//
//  Created by Towhid on 9/9/14.
//  Copyright (c) 2014 Towhid (Selise.ch). All rights reserved.
//

import UIKit
import CoreDataStack

@objc(Credential)
@objcMembers
open class Credential: NGObject {
    
    fileprivate let emailIdentifier: String = "\(Bundle.main.bundleIdentifier!).user_email"
    fileprivate let passwordIdentifier: String = "\(Bundle.main.bundleIdentifier!).user_password"
    fileprivate let rememberIdentifier: String = "\(Bundle.main.bundleIdentifier!).user_remember"
    
    public var isRemembered: Bool{
        get{
            let valueInString = KeychainWrapper.keychainStringFrom(matchingIdentifier: rememberIdentifier)
            return (valueInString == nil) ? false : valueInString == "true"
        }
        set{
            let valueInString = (newValue == true) ? "true" : "false"
            KeychainWrapper.createKeychainValue(valueInString, forIdentifier: rememberIdentifier)
        }
    }
   
    public var email: String?{
        get{
            return KeychainWrapper.keychainStringFrom(matchingIdentifier: emailIdentifier)
        }
        set{
            KeychainWrapper.createKeychainValue(newValue, forIdentifier: emailIdentifier)
        }
    }
    
    public var password: String?{
        get{
            return KeychainWrapper.keychainStringFrom(matchingIdentifier: passwordIdentifier)
        }
        set{
            KeychainWrapper.createKeychainValue(newValue, forIdentifier: passwordIdentifier)
        }
    }
    
    open override func updateValue(_ value: Any!, forKey key: String!) {
        if key == "email" {
            email = value as? String
        }
        else if key == "password" {
            password = value as? String
        }
        else{
            super.updateValue(value, forKey: key)
        }
    }
    
    open func removeCredential(_ passwordOnly:Bool){
        //if not true then remove only password
        //else remove both
        if passwordOnly != true{
            if let _ = KeychainWrapper.keychainStringFrom(matchingIdentifier: emailIdentifier){
                KeychainWrapper.deleteItemFromKeychain(withIdentifier: emailIdentifier)
            }
        }
        if let _ = KeychainWrapper.keychainStringFrom(matchingIdentifier: passwordIdentifier){
            KeychainWrapper.deleteItemFromKeychain(withIdentifier: passwordIdentifier)
        }
        if let _ = KeychainWrapper.keychainStringFrom(matchingIdentifier: rememberIdentifier){
            KeychainWrapper.deleteItemFromKeychain(withIdentifier: rememberIdentifier)
        }
    }
}
