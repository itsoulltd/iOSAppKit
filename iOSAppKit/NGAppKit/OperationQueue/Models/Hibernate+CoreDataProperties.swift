//
//  Hibernate+CoreDataProperties.swift
//  NGOperationQueue
//
//  Created by Towhid Islam on 6/6/17.
//  Copyright © 2017 Towhid Islam. All rights reserved.
//

import Foundation
import CoreData
import CoreDataStack

extension Hibernate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hibernate> {
        return NSFetchRequest<Hibernate>(entityName: "Hibernate");
    }

    @NSManaged public var info: NGObject?
    @NSManaged public var createDate: NSDate?

}
