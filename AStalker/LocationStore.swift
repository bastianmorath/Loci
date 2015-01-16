//
//  LocationStore.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData
import AddressBook
import UIKit


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
        var user = self.coreDataStore.performFetch("User")
        for (index, object) in enumerate(user as [User]) {
            if object == self.getLocalUser(){
                user!.removeAtIndex(index)
            }
        }
        
        return user! as [User]
    }
    
 // Get all User as NSFetchedResultsController
    func getUsersFC() -> NSFetchedResultsController {
        let predicate = NSPredicate(format: "NOT (self == %@)", self.getLocalUser()!)

        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        
        return coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
    }
    
    // Get all Friends as NSFetchedResultsController
    func getFriendsFC() -> NSFetchedResultsController {
        let predicate = NSPredicate(format: "self IN %@", self.getLocalUser()!.friends)

        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc
    }
    
    // Get all User without Friends as NSFetchedResultsController
    func getUsersWithoutFriendsFC() -> NSFetchedResultsController{
        let predicate = NSPredicate(format: "NOT (self IN %@) && NOT (self == %@)", self.getLocalUser()!.friends, self.getLocalUser()!)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc

    }

    
    //TODO: LocalUser verbessern, nil prüfen
    func getLocalUser() -> LocalUser?{
        var localUserArray = self.coreDataStore.performFetch("LocalUser") as [LocalUser]
        return localUserArray.first?
    }
    
    func getMySharedLocationsFC() -> NSFetchedResultsController{
        let predicate = NSPredicate(format: "self IN %@", self.getLocalUser()!.mySharedLocations)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("Location", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc
    }
    
    /**************************** WRITE Methods **********************************/
    func createUser(name: String) -> User? {
        var userObject = self.coreDataPortal.createObject("User") as User?
        if let user = userObject {
            user.name = name
            self.coreDataPortal.save()
            return user
        }
        return nil
    }
    
    func createLocalUser(name: String, phoneNumber: String) -> LocalUser{
        var localUserArray = self.coreDataStore.performFetch("LocalUser")! as [LocalUser]
        //Prüft, ob schon ein LocalUser vorhanden ist
        if localUserArray.count>0 {
            return localUserArray.first!
        } else {
            var user = self.coreDataPortal.createObject("LocalUser") as LocalUser
            user.name = name
            user.phoneNumber = phoneNumber
            self.coreDataPortal.save()
            return user
        }
    }
    
    /**
    Erstellt eine Location mit Name, Timestamp, Longitude und latitude.
    Der User ist optional: Wird einer mitgeliefert, wird die Location dem Property 'sharedLocation' des Users, anderfalls des LcoalUsers hinzugefügt.
    */
    func createLocation(name: String, timestamp: NSDate? = nil, longitude: Double, latitude: Double, user: User? = nil) -> Location?{
        var locationObject = self.coreDataPortal.createObject("Location") as Location?
        if let location = locationObject {
            location.name = name
            if let timestamp = timestamp {
            location.timestamp = timestamp
            }
            location.longitude = longitude
            location.latitude = latitude
            if let user = user {
                location.creator = user
            }
            return location
        }
        return nil
    }
    
    /**************************** Create Debug Objects **********************************/
    func createDebugUsers(){
        var nameArray = ["Bastian Morath", "Aleksandar Papez", "Lukas Reichart", "Florian Morath", "Cheryl Vaterlaus", "Elisa Mischi"]
        
        for name in nameArray {
            self.createUser(name)
        }
    }
    
    func createDebugLocalUser(){
        var localUser = self.createLocalUser("Bastian Morath", phoneNumber: "07954501010")
        let userArray =  self.getUser()
        let friendsArray = [userArray[0], userArray[2], userArray[4]]
        var mySharedLocationsArray: [Location] = []
        for i in 1...10 {
            let name = "Location \(i)"
            var todaysDate:NSDate = NSDate()
            var location = self.createLocation(name, timestamp: todaysDate, longitude: Double(i) * 3, latitude: Double()*2, user: userArray[0])
            mySharedLocationsArray.append(location!)
        }

        
        localUser.mySharedLocations = NSSet(array: mySharedLocationsArray)
        localUser.contacts = NSSet(array: userArray)
        localUser.friends = NSSet(array: friendsArray)
    }
}