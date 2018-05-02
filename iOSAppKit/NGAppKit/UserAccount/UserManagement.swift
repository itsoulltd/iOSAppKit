//
//  UserAccountManager.swift
//  MymoUpload
//
//  Created by Towhid on 9/9/14.
//  Copyright (c) 2014 Towhid (Selise.ch). All rights reserved.
//

import UIKit
import Foundation
import CoreDataStack

@objc(UserManagement)
open class UserManagement: NGObject {
    
    var profile: NGObjectProtocol?{
        get{
            guard let data = UserDefaults.standard.data(forKey: "userProfileKey") else{
                return nil
            }
            let unarchived = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:AnyObject]
            let inferred = self.profileType.init()
            inferred.update(withInfo: unarchived)
            return inferred
        }
        set{
            let infos: [String:AnyObject] = newValue?.serializeIntoInfo() as! [String:AnyObject]
            let archived = NSKeyedArchiver.archivedData(withRootObject: infos)
            UserDefaults.standard.set(archived, forKey: "userProfileKey")
            UserDefaults.standard.synchronize()
        }
    }
    
    open func deleteProfile(){
        if self.profile != nil {
            UserDefaults.standard.removeObject(forKey: "userProfileKey")
        }
    }
    
    open func updateProfile(_ value: AnyObject, forKey key: String){
        guard let xProfile = profile else{
            return
        }
        xProfile.updateValue(value, forKey: key)
        let infos: [String:AnyObject] = xProfile.serializeIntoInfo() as! [String:AnyObject]
        let archived = NSKeyedArchiver.archivedData(withRootObject: infos)
        UserDefaults.standard.set(archived, forKey: "userProfileKey")
        UserDefaults.standard.synchronize()
    }
    
    fileprivate var profileType: NGObject.Type = NGObject.self
    var oauth: OAuth = OAuth()
    var credential: Credential = Credential()
    
    var loggedIn: Bool = false
    
    var token: String? {
        return oauth.token
    }
    
    public override init() {
        super.init()
        if (oauth.token != nil && credential.password != nil){
            loggedIn = true
        }else{
            loggedIn = false
        }
    }
    
    public convenience init(profileType: NGObject.Type) {
        self.init()
        self.profileType = profileType
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func logout(_ passwordOnly:Bool = false){
        loggedIn = false
        oauth.removeToken()
        credential.removeCredential(passwordOnly)
    }
    
    open func loginWithToken(_ token: String, email: String, password: String, remembered: Bool = false) -> Bool{
        oauth.token = token
        credential.update(withInfo: ["email":email,"password":password])
        credential.isRemembered = remembered
        loggedIn = true
        return loggedIn
    }
}
