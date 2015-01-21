//
//  User.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var sharedLocations: NSSet
    @NSManaged var friends: NSSet
    @NSManaged var contacts: NSSet
}

extension User{
    func addFriendObject(friend: User?){
        var friends = self.mutableSetValueForKey("friends")
        friends.addObject(friend!)
    }
    
    func removeFriendObject(friend: User?){
        var friends = NSMutableSet(set: self.friends)
        
        friends.removeObject(friend!)
        self.friends = friends
    }
}