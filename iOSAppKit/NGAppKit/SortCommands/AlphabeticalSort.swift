//
//  AlphabeticalSort.swift
//  StartupProjectSampleA
//
//  Created by Towhid on 8/16/15.
//  Copyright (c) 2015 Towhid (Selise.ch). All rights reserved.
//

import Foundation
import CoreDataStack

@objc(AlphabeticalSort)
open class AlphabeticalSort: SortCommand {
    
    open override func sort(inMemory collection: inout [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult = ComparisonResult.orderedAscending) -> [NGObjectProtocol] {
        self.order = order
        collection.sort { (first, second) -> Bool in
            return self.compare(first as! NSObject, second: second as! NSObject, forKeyPath: keyPath)
        }
        return collection
    }
    
    open override func sort(_ collection: [NGObjectProtocol], forKeyPath keyPath: String?, order: ComparisonResult = ComparisonResult.orderedAscending) -> [NGObjectProtocol] {
        self.order = order
        let sorted = collection.sorted { (first, second) -> Bool in
            return self.compare(first as! NSObject, second: second as! NSObject, forKeyPath: keyPath)
        }
        return sorted
    }
}
