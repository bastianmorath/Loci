//
//  LocationStore.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class LocationStore: NSObject{
    var coreDataStore: ACoreDataStore = ACoreDataStore.defaultStore()
    var coreDataPortal: ACoreDataPortal = ACoreDataStore.defaultStore()
    
    /**
    Singleton function returns the default Instance of this Store.
    
    :returns: returns the default instance.
    */
    class func defaultStore() -> LocationStore {
        struct StaticInstance {
            static var instance: LocationStore?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once( &StaticInstance.token ) {
            StaticInstance.instance = LocationStore()
        }
        
        return StaticInstance.instance!
    }
    
    /**************************** READ Methods **********************************/
    func getUser() -> [User]{
        return self.coreDataStore.performFetch("User") as [User]
    }
    
    /*
    :returns: Returns a NSFetchedResultsController for all User.
    */
    func getUserFetchedResultsController() -> NSFetchedResultsController {
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        
        return coreDataStore.createFetchedResultsController("User", predicate: nil, sortDescriptors: [sortDescriptor] )
    }
    
    //TODO: LocalUser verbessern, nil prüfen
    func getLocalUser() -> LocalUser?{
        var localUserArray = self.coreDataStore.performFetch("LocalUser") as [LocalUser]
       return localUserArray.first
    }
    
    func getContacts(){
        
    }
    
    
    
    /**************************** WRITE Methods **********************************/
    func createUser(name: String) -> User? {
        var userObject = self.coreDataPortal.createObject("User") as User?
        if let user = userObject {
            user.name = name
            return user
        }
        return nil
    }
    
    func createLocalUser(name: String, phoneNumber: String) -> LocalUser?{
        var user = self.coreDataPortal.createObject("LocalUser") as LocalUser?
        if let localUser = user {
            localUser.phoneNumber = phoneNumber
            return localUser
        }
        return nil
    }
    
    /**
    Erstellt eine Location mit Name, Timestamp, Longitude und latitude.
    Der User ist optional: Wird einer mitgeliefert, wird die Location dem Property 'sharedLocation' des Users, anderfalls des LcoalUsers hinzugefügt.
    */
    func createLocation(name: NSString, timestamp: NSDate, longitude: Double, latitude: Double, user: User? = nil) -> Location?{
        var locationObject = self.coreDataPortal.createObject("Location") as Location?
        if let location = locationObject {
            location.name = name
            location.timestamp = timestamp
            location.longitude = longitude
            location.latitude = latitude
            if (user != nil) {
                user!.sharedLocations = user!.sharedLocations.setByAddingObject(location)
            } else {
                
            }
            return location
        }
        return nil
    }
}