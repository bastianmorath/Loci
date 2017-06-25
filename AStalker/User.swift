//
//  User.swift
//  Loci
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
    func addFriendObject(_ friend: User?){
        let friendsArray = self.mutableSetValue(forKey: "friends")
        friendsArray.add(friend!)
        self.friends = friendsArray
    }
    
    
    func removeFriendObject(_ friend: User?){
        let friendsArray = self.mutableSetValue(forKey: "friends")
        friendsArray.remove(friend!)
        self.friends = friendsArray
    }
}
