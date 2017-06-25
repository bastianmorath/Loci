//
//  Notification.swift
//  Loci
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class Notification: NSManagedObject {

    @NSManaged var timestamp: Date
    @NSManaged var creator: User
    @NSManaged var location: Location

}
