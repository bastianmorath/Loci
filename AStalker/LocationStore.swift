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
    
    /**
    Diese Methode gibt ein Array zurück. Dieser enthält pro Kontakt ein Dictionary mit den Daten des Kontaktes. Welche Properties im Dictionary gespeichert werden sollen, kann über die Boolsche Variabeln dieser Methode bestummen werden.
    
    :returns: Ein Array mit Dictionaries
    */
    func getContacts(addFirstName: Bool = true, addLastName: Bool = false, addPhoneNumber: Bool = false) -> [Dictionary<String, String>]?{
        
        if AddressBook.defaultStore().accesAuthorized() {
            let addressBook: ABAddressBookRef = AddressBook.defaultStore().addressBook as ABAddressBookRef
            let allPeople = ABAddressBookCopyArrayOfAllPeople(
                addressBook).takeRetainedValue() as NSArray
            var dictArray:[Dictionary<String, String>] = []
            
            for person in allPeople{
                
                var personDictionary = ["String":"String"]
                if addFirstName{
                    let firstName = ABRecordCopyValue(person,
                        kABPersonFirstNameProperty).takeRetainedValue() as String
                    personDictionary.updateValue(firstName, forKey: "firstName")
                }
                if addLastName{
                    let lastName = ABRecordCopyValue(person,
                        kABPersonLastNameProperty).takeRetainedValue() as String
                    personDictionary.updateValue(lastName, forKey: "lastName")
                }
                if addPhoneNumber{
                    let phoneNumber = ABRecordCopyValue(person,
                        kABPersonFirstNameProperty).takeRetainedValue() as String
                    //personDictionary.updateValue(firstName, forKey: "firstName")
                }
                dictArray.append(personDictionary)
            }
            
            return dictArray
        } else {
            return nil
        }
    }
    
//    func getMobileNumberFromABRecordRef(ref: ABRecordRef) -> String{
//        var multiRef: ABMutableMultiValueRef = ABRecordCopyValue(ref, kABPersonPhoneProperty)
//        for i in multiRef{
//            var mobileLabel = ABMultiValueCopyLabelAtIndex(multiRef, i)
//            if mobileLabel.
//        }
//    }
    
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