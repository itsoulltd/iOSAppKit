//
//  SortCommand.swift
//  RufDriveApp
//
//  Created by Towhid on 7/29/15.
//  Copyright (c) 2015 md arifuzzaman. All rights reserved.
//

import Foundation
import CoreDataStack

public protocol SortCommandProtocol: NSObjectProtocol{
    static func restoreSharedCommand(defaultSortType sortType: NGObject.Type) -> SortCommand
    static func restoreCommand(byKey key: String) -> SortCommand?
    static func storeSharedCommand(_ command: SortCommand) -> Void
    static func storeCommand(_ command: SortCommand, byKey key: String) -> Void
    func sort(inMemory collection: inout [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult) -> [NGObjectProtocol]
    func sort(_ collection: [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult) -> [NGObjectProtocol]
    func compare(_ first: NSObject, second: NSObject, forKeyPath keyPath: String?) -> Bool
    func isDateType(forKeyPath keyPath: String?) -> Bool
    func date(fromString stringValue: String?) -> Date?
    func preferredSortOrder() -> ComparisonResult
}

@objc(SortCommand)
open class SortCommand: NGObject, SortCommandProtocol {
    
    open class func restoreSharedCommand(defaultSortType sortType: NGObject.Type = SortCommand.self) -> SortCommand{
        if let savedObject = SortCommand.restoreCommand(byKey: "SharedCommandKey"){
            return savedObject
        }
        let dynamicObj = sortType.init()
        return dynamicObj as! SortCommand
    }
    
    open class func restoreCommand(byKey key: String) -> SortCommand?{
        if let savedObject = UserDefaults.standard.object(forKey: key) as? Data{
            let unarchived = NSKeyedUnarchiver.unarchiveObject(with: savedObject) as? SortCommand
            return unarchived
        }
        return nil
    }
    
    open class func storeSharedCommand(_ command: SortCommand) -> Void{
        SortCommand.storeCommand(command, byKey: "SharedCommandKey")
    }
    
    open class func storeCommand(_ command: SortCommand, byKey key: String) -> Void{
        let archived = NSKeyedArchiver.archivedData(withRootObject: command)
        UserDefaults.standard.set(archived, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    open func sort(inMemory collection: inout [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult = ComparisonResult.orderedAscending) -> [NGObjectProtocol]{
        self.order = order
        collection.sort { (first, second) -> Bool in
            return self.compare(first as! NSObject, second: second as! NSObject, forKeyPath: keyPath)
        }
        return collection
    }
    
    open func sort(_ collection: [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult = ComparisonResult.orderedAscending) -> [NGObjectProtocol]{
        self.order = order
        let sorted = collection.sorted { (first, second) -> Bool in
            return self.compare(first as! NSObject, second: second as! NSObject, forKeyPath: keyPath)
        }
        return sorted
    }
    
    open var order: ComparisonResult = ComparisonResult.orderedAscending
    open func preferredSortOrder() -> ComparisonResult {
        return order
    }
    
    open func isDateType(forKeyPath keyPath: String?) -> Bool {
        return false
    }
    
    open func date(fromString stringValue: String?) -> Date? {
        return nil
    }
    
    open func compare(_ first: NSObject, second: NSObject, forKeyPath keyPath: String?) -> Bool{
        if isDateType(forKeyPath: keyPath){
            if let firstDate = getDate(fromValue: first.value(forKeyPath: keyPath!)! as AnyObject){
                if let secondDate = getDate(fromValue: second.value(forKeyPath: keyPath!)! as AnyObject){
                    let comparison = firstDate.compare(secondDate)
                    //ByDefault Date is Descending Order
                    return comparison == self.preferredSortOrder()
                }
            }
            return false
        }
        else{
            let firstValue: AnyObject? = first.value(forKeyPath: keyPath!) as AnyObject?
            let secondValue: AnyObject? = second.value(forKeyPath: keyPath!) as AnyObject?
            if let firstString = getString(fromValue: firstValue!){
                if let secondString = getString(fromValue: secondValue!){
                    if firstValue is NSNumber{
                        //ByDefault Number is Ascending Order
                        return firstString.compare(secondString as String, options: NSString.CompareOptions.numeric) == self.preferredSortOrder()
                    }
                    else{
                        //ByDefault String is Ascending Order
                        return firstString.compare(secondString as String, options: NSString.CompareOptions.literal) == self.preferredSortOrder()
                    }
                }
            }
            return false
        }
    }
    
    fileprivate func getDate(fromValue value: AnyObject) -> Date?{
        if value is Date{
            return value as? Date
        }
        else{
            return date(fromString: value as? String)
        }
    }
    
    fileprivate func getString(fromValue value: AnyObject) -> NSString?{
        if value is NSNumber{
            return (value as? NSNumber)?.stringValue as NSString?
        }
        else if value is String{
            return value as? NSString
        }
        return nil
    }
    
}

