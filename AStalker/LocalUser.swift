//
//  LocalUser.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class LocalUser: User {

    @NSManaged var phoneNumber: String
    @NSManaged var userID: String
    @NSManaged var notifications: NSSet

}
