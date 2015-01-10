//
//  LocationStore.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation

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
    func getContacts() -> [User]{
        return self.coreDataStore.performFetch("User") as [User]
    }
    
    /**************************** WRITE Methods **********************************/


}