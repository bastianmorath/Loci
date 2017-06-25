//
//  SharedLocation.swift
//  AStalker
//
//  Created by Bastian Morath on 10/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class SharedLocation: AStalker.Location {
    @NSManaged var timestamp: Date
    @NSManaged var creator: User
    @NSManaged var sharedUsers: NSSet
}
