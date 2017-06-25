//
//  LocationStore.swift
//  Loci
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData
import AddressBook
import UIKit


class LocationStore: NSObject{
    
    private static var __once: () = {
            StaticInstance.instance = LocationStore()
        }()
    
    var coreDataStore: ACoreDataStore = ACoreDataStore.defaultStore()
    var coreDataPortal: ACoreDataPortal = ACoreDataStore.defaultStore()
    
    /**
    Singleton function returns the default Instance of this Store.
    
    :returns: returns the default instance.
    */
    class func defaultStore() -> LocationStore {
        struct StaticInstance {
            static var instance: LocationStore?
            static var token: Int = 0
        }
        
        _ = LocationStore.__once
        
        return StaticInstance.instance!
    }
    
    /**************************** READ Methods **********************************/
    func getUser() -> [User]{
        var user = self.coreDataStore.performFetch("User")
        for (index, object) in (user?.enumerated())! {
            if object == self.getLocalUser(){
                user!.remove(at: index)
            }
        }
        
        return user as! [User]
    }
    
    // Get all User as NSFetchedResultsController
    func getUsersFC() -> NSFetchedResultsController<NSFetchRequestResult> {
        let predicate = NSPredicate(format: "NOT (self == %@)", self.getLocalUser()!)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        
        return coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
    }
    
    // Get all Friends as NSFetchedResultsController
    func getFriendsFC() -> NSFetchedResultsController<NSFetchRequestResult> {
        let predicate = NSPredicate(format: "self IN %@", self.getLocalUser()!.friends)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc
    }
    
    // Get all User without Friends as NSFetchedResultsController
    func getUsersWithoutFriendsFC() -> NSFetchedResultsController<NSFetchRequestResult>{
        let predicate = NSPredicate(format: "NOT (self IN %@) && NOT (self == %@)", self.getLocalUser()!.friends, self.getLocalUser()!)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("User", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc
        
    }
    
    
    //TODO: LocalUser verbessern, nil prüfen
    func getLocalUser() -> LocalUser?{
        var localUserArray = self.coreDataStore.performFetch("LocalUser") as! [LocalUser]
        return localUserArray.first
    }
    
    func getMySharedLocationsFC() -> NSFetchedResultsController<NSFetchRequestResult>{
        let predicate = NSPredicate(format: "self IN %@", self.getLocalUser()!.mySharedLocations)
        
        // sort them alphabetically
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true )
        let frc = coreDataStore.createFetchedResultsController("SharedLocation", predicate: predicate, sortDescriptors: [sortDescriptor])
        return frc
    }
    
    //TODO:- Seine eigenen Locations fetchen. MOmentan werden die Locations gefetched, welche ich selber geshared habe
    func getFavoriteLocationsFC() -> NSFetchedResultsController<NSFetchRequestResult>{
        
        // TODO:- Nach hoursSpent sortieren
        let sortDescriptor1 = NSSortDescriptor(key: "isFavorite", ascending: false )
        let sortDescriptor2 = NSSortDescriptor(key: "timeSpent", ascending: false )

        let frc = coreDataStore.createFetchedResultsController("FavoriteLocation", predicate: nil, sortDescriptors: [sortDescriptor1, sortDescriptor2])
        
        return frc
    }
    
    // Gibt die "Unterwegs"-Favorite Location zurück
    func  getOnTheWayLocation() -> FavoriteLocation{
        let predicate = NSPredicate(format: "self.name == %@", "Unterwegs")
        
        // sort them alphabetically
        let location = self.coreDataStore.performFetch("FavoriteLocation", predicate: predicate, sortDescriptors: nil)?[0]
        return location as! FavoriteLocation
    }
    
    
    /**************************** WRITE Methods **********************************/
    func createUser(_ name: String) -> User? {
        var userObject = self.coreDataPortal.createObject("User") as? User
        if let user = userObject {
            user.name = name
            self.coreDataPortal.save()
            return user
        }
        return nil
    }
    
    func createLocalUser(_ name: String, phoneNumber: String) -> LocalUser{
        var localUserArray = self.coreDataStore.performFetch("LocalUser")! as! [LocalUser]
        //Prüft, ob schon ein LocalUser vorhanden ist
        if localUserArray.count>0 {
            return localUserArray.first!
        } else {
            var user = self.coreDataPortal.createObject("LocalUser") as! LocalUser
            user.name = name
            user.phoneNumber = phoneNumber
            self.coreDataPortal.save()
            return user
        }
    }
    
    //TODO:- SaveFunktion funktioniert nicht...
    func addUserToFriendsOfLocalUser(_ user: User?){
        if let user = user{
            self.getLocalUser()!.addFriendObject(user)
            self.coreDataPortal.save()
        }
    }
    
    
    func deleteUserInFriendsOfLocalUser(_ user: User?){
        if let user = user{
            self.getLocalUser()!.removeFriendObject(user)
            self.coreDataPortal.save()
        }
    }
    
    /**
    Erstellt eine Location mit Timestamp, Longitude und latitude.
    Der User ist optional: Wird einer mitgeliefert, wird die Location dem Property 'sharedLocation' des Users, anderfalls des LcoalUsers hinzugefügt.
    */
    func createSharedLocation(_ timestamp: Date? = nil, longitude: Double, latitude: Double, user: User? = nil) -> SharedLocation?{
        var locationObject = self.coreDataPortal.createObject("SharedLocation") as? SharedLocation
        if let location = locationObject {
            if let timestamp = timestamp {
                location.timestamp = timestamp
            }
            location.longitude = NSNumber(longitude)
            location.latitude = NSNumber(latitude)
            if let user = user {
                location.creator = user
            }
            self.coreDataPortal.save()
            return location
        }
        return nil
    }
    
    /**
    Erstellt eine FavoriteLocation mit Name, Timestamp, Longitude und latitude.
    Der User ist optional: Wird einer mitgeliefert, wird die Location dem Property 'sharedLocation' des Users, anderfalls des LcoalUsers hinzugefügt.
    */
    func createFavoriteLocation(_ name: String? = nil, longitude: Double, latitude: Double) -> FavoriteLocation?{
        var locationObject = self.coreDataPortal.createObject("FavoriteLocation") as? FavoriteLocation
        if let location = locationObject {
            
            location.longitude = NSNumber(longitude)
            location.latitude = NSNumber(latitude)

            if let name = name {
                location.name = name
            } else {
                location.name = ""
            }

            self.coreDataPortal.save()
            return location
        }
        return nil
    }
    
    // Erstellt eine "Unterwegs"-Favorite location (nur einmal)
    func  createOnTheWayLocation(){
        let onTheWayLocation = self.createFavoriteLocation("Unterwegs", longitude: 0, latitude: 0)
        onTheWayLocation?.isFavorite = true
    }
    
    /**************************** Create Debug Objects **********************************/
    func createDebugUsers(){
        let nameArray = [ "Aleksandar Papez", "Lukas Reichart", "Florian Morath", "Cheryl Vaterlaus", "Elisa Mischi", "Benjamin Morath", "Dominik Grimm", "Robin Lingwood", "Frederic Huber", "Benjamin Weiss", "Selina Schenker", "Dio Moonnee"]
        for name in nameArray {
            self.createUser(name)
        }
    }
    
    func createDebugLocalUser(){
        let localUser = self.createLocalUser("Bastian Morath", phoneNumber: "07954501010")
        let userArray =  self.getUser()
        let friendsArray = [userArray[0], userArray[2], userArray[4]]
        // Create debug Shared Locations
        var mySharedLocationsArray: [SharedLocation] = []
        for i in 1...13 {
            var name: String?
            if i<3{
                name = "Location \(i)"
            }
            let todaysDate:Date = Date()
            let sharedLocation = self.createSharedLocation(todaysDate, longitude: Double(i) * 3, latitude: Double()*2, user: userArray[0])
            mySharedLocationsArray.append(sharedLocation!)
        }
        
//        // Create debug Favorite Locations
//        var myFavoriteLocationsArray: [FavoriteLocation] = []
//        for i in 1...3 {
//            var name: String?
//            if i<3{
//                name = "Location \(i)"
//            }
//            var todaysDate:NSDate = NSDate()
//            var favoriteLocation = self.createFavoriteLocation(name: name, longitude: Double(i) * 3-4, latitude: Double()*2+5)
//            if i==1{
//                localUser.currentLocation = favoriteLocation!
//            }
//            
//            myFavoriteLocationsArray.append(favoriteLocation!)
//        }
        
        localUser.mySharedLocations = NSSet(array: mySharedLocationsArray)
        //localUser.favoriteLocations = NSSet(array: myFavoriteLocationsArray)
        
        localUser.contacts = NSSet(array: userArray)
        localUser.friends = NSSet(array: friendsArray)
        
        self.coreDataPortal.save()
    }
}
