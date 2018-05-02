//
//  OAuth.swift
//  MymoUpload
//
//  Created by Towhid on 9/9/14.
//  Copyright (c) 2014 Towhid (Selise.ch). All rights reserved.
//

import UIKit
import CoreDataStack

@objc(OAuth)
open class OAuth: NGObject {
    
    fileprivate let tokenIdentifier: String = "\(Bundle.main.bundleIdentifier!).user_token"
   
    var token: String?{
        get{
            return KeychainWrapper.keychainStringFrom(matchingIdentifier: tokenIdentifier)
        }
        set{
            KeychainWrapper.createKeychainValue(newValue, forIdentifier: tokenIdentifier)
        }
    }
    var secretKey: String?
    
    open override func updateValue(_ value: Any!, forKey key: String!) {
        if key == "token"{
            token = value as? String
        }
        else if key == "secretKey"{
            secretKey = value as? String
        }
        else{
            super.updateValue(value, forKey: key)
        }
    }
    
    open func removeToken(){
        //just remove token from keyChain
        if let _ = KeychainWrapper.keychainStringFrom(matchingIdentifier: tokenIdentifier){
            KeychainWrapper.deleteItemFromKeychain(withIdentifier: tokenIdentifier)
        }
    }
}
