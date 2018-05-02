//
//  UserProfile.swift
//  MymoUpload
//
//  Created by Towhid on 9/9/14.
//  Copyright (c) 2014 Towhid (Selise.ch). All rights reserved.
//

import UIKit
import CoreDataStack

@objc(UserProfile)
open class UserProfile: NGObject {
   
    var firstName: String?
    var lastName: String?
    var name: String {
        guard let fn = firstName
            , let ln = lastName else {
                return ""
        }
        return "\(fn) \(ln)"
    }
    var age: Int?
    var dob: Date?
    var profileImagePath: URL?
    var thumbNailPath: URL?
    
    open override func updateValue(_ value: Any!, forKey key: String!) {
        
        if key == "firstName"{
            firstName = value as? String
        }
        else if key == "lastName"{
            lastName = value as? String
        }
        else if key == "age"{
            
            if let val = value as? String{
                age = Int(val)
            }
            else{
                age = value as? Int
            }
        }
        else if key == "dob"{
            if let dobStr = value as? String{
                dob = updateDate(dobStr)
            }
        }
        else{
            super.updateValue(value, forKey: key)
        }
    }
    
    open override func updateDate(_ dateStr: String!) -> Date! {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.date(from: dateStr)
    }
    
    open override func serializeDate(_ date: Date!) -> String! {
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}
