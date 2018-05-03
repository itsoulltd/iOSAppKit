//
//  Registration.swift
//  MymoUpload
//
//  Created by Towhid on 9/11/14.
//  Copyright (c) 2014 Towhid (Selise.ch). All rights reserved.
//

import UIKit
import CoreDataStack

@objcMembers
open class Registration: NGObject {
    public var email :NSString?
    public var password :NSString?
    public var passwordConfirmation :NSString?
    public var firstName :NSString?
    public var lastName :NSString?
}
