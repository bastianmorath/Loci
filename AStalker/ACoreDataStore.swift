//
//  ACoreDataStore.swift
//  Trainer
//
//  Created by Lukas Reichart on 18/12/14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import CoreData

/**
*  The ACoreDataStore class is a wrapper class for writing to core data.
It is used for:
- Reading data from the database
- responsible for the main and the master NSManagedObjectContext
- creating ACoreDataPortal objects, that can be used to perform async writing.
*/
final class ACoreDataStore: ACoreDataPortal {
  
  private var managedObjectModel: NSManagedObjectModel!
  private var persistenStoreCoordinator: NSPersistentStoreCoordinator!
  
  /**
  The defaultStore exposes the default instance of this class. Generally you will
  always use this to get an instace.
  
  :returns: the shared instance of the ACoreDataStore
  */
  class func defaultStore()-> ACoreDataStore {
    struct StaticInstance {
      static var instance: ACoreDataStore?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once( &StaticInstance.token ) {
      StaticInstance.instance = ACoreDataStore()
    }
    
    return StaticInstance.instance!
  }
  
  /**
  Initializes the coreDataStack.
  */
  override init() {
    super.init()
    
    var error = setupCoreDataStack()
    if error != nil {
      // TODO: Add system to deal with the error
    }
    
  }
  
  /**
  This function does the heavy setup lifting: It creates the core data Stack with a persistenStoreCoordinator
  the different managedObjectContexts.
  
  :returns: optional NSError
  */
  private func setupCoreDataStack() -> NSError? {
    managedObjectModel = NSManagedObjectModel.mergedModelFromBundles( nil )
    
    let storeURL = NSURL( fileURLWithPath: NSHomeDirectory() + "/Documents/trainer.db" )
    
    var error: NSError?
    persistenStoreCoordinator = NSPersistentStoreCoordinator( managedObjectModel: managedObjectModel )
    
    
    // create our custom networking store
//    ABackendIncrementalStore.initialize()
//    persistenStoreCoordinator.addPersistentStoreWithType( "Trainer.ABackendIncrementalStore", configuration: nil, URL: nil, options: nil, error: &error)
//    if error != nil {
//      return error
//    }
    
    // create the persisten Disk Store
    persistenStoreCoordinator.addPersistentStoreWithType( NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error )
    if error != nil {
      return error
    }
    
    // create the managedObjectContext
    managedObjectContext = NSManagedObjectContext( concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType )
    managedObjectContext.persistentStoreCoordinator = persistenStoreCoordinator
    
    return nil
  }
  
  /**************************** API for reading data **********************************/
  /**
  Internal utility function for creating a fetch request.
  
  :param: entityName      the entity to fetch
  :param: predicate       NSPredicate to filter the results
  :param: sortDescriptors NSSortDescriptor to sort the results
  
  :returns: the newly created NSFetchRequest
  */
  internal func createFetchRequest( entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil ) -> NSFetchRequest {
    
    var fetchRequest = NSFetchRequest(entityName:  entityName )
    fetchRequest.predicate = predicate
    fetchRequest.sortDescriptors = sortDescriptors
    fetchRequest.fetchBatchSize = 10
    
    return fetchRequest
  }
  
  
  /**
  The function performs a simple one time fetch and returns the result as an Array.
  
  :returns: Results in an arra
  */
  func performFetch( entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil ) -> [NSManagedObject]? {
    let fetchRequest = createFetchRequest( entityName, predicate: predicate, sortDescriptors: sortDescriptors )
    
    var error: NSError?
    let result = managedObjectContext.executeFetchRequest( fetchRequest, error: &error)
    
    return result as [NSManagedObject]?
  }
  
  /**
  Creates a NSFetchedResultsController for the given entity.
  
  :returns: The newly created NSFetchedResultsController
  */
  func createFetchedResultsController( entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil ) -> NSFetchedResultsController {
    
    let fetchRequest = createFetchRequest( entityName, predicate: predicate, sortDescriptors: sortDescriptors )
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil )
    
    var error: NSError?
    fetchedResultsController.performFetch( &error )
    
    return fetchedResultsController
  }
  

}





