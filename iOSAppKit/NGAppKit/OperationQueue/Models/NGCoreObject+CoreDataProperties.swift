//
//  NGCoreObject+CoreDataProperties.swift
//  NGOperationQueue
//
//  Created by Towhid Islam on 6/6/17.
//  Copyright © 2017 Towhid Islam. All rights reserved.
//

import Foundation
import CoreData
import CoreDataStack

extension NGCoreObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NGCoreObject> {
        return NSFetchRequest<NGCoreObject>(entityName: "NGCoreObject");
    }

}
