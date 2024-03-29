//
//  Loci.swift
//  Loci
//
//  Created by Bastian Morath on 16/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class LocalUser: User {

    @NSManaged var phoneNumber: String
    @NSManaged var userID: String
    @NSManaged var mySharedLocations: NSSet
    @NSManaged var favoriteLocations: NSSet
    @NSManaged var notifications: NSSet
    @NSManaged var currentLocation: Location

}
