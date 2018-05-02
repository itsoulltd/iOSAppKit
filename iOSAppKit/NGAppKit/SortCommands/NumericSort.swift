//
//  NumericSort.swift
//  StartupProjectSampleA
//
//  Created by Towhid on 8/16/15.
//  Copyright (c) 2015 Towhid (Selise.ch). All rights reserved.
//

import Foundation

@objc(NumericSort)
open class NumericSort: SortCommand {
    
    open override func compare(_ first: NSObject, second: NSObject, forKeyPath keyPath: String?) -> Bool {
        let firstValue: AnyObject? = first.value(forKeyPath: keyPath!) as AnyObject?
        let secondValue: AnyObject? = second.value(forKeyPath: keyPath!) as AnyObject?
        if firstValue is NSNumber{
            //ByDefault Number is Ascending Order
            return (firstValue as! NSNumber).compare((secondValue as! NSNumber)) == preferredSortOrder()
        }
        else{
            //ByDefault String is Ascending Order
            return compare(first, second: second, forKeyPath: keyPath)
        }
    }
    
}
