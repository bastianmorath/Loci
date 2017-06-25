//
//  ATableViewDataSource.swift
//  Trainer
//
//  Created by Lukas Reichart on 19/12/14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
*  The ATableViewDataSource class is used as a DataSource for UITableViews.
*  It uses a NSFetchedResultsController to retrieve the data to display and autmatically
*  updating the table view as changes to the data happend.
*/
class ATableViewDataSource: NSObject {
  /// Use a NSFetchedResultsController as the underlying data source.
  internal var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
  
  /// The tableView that is provided with data by this objct
  internal var tableView: UITableView!
  
  init( tableView: UITableView, fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> ) {
      
    super.init()
    
    self.fetchedResultsController = fetchedResultsController
    fetchedResultsController.delegate = self
      
    self.tableView = tableView
  }
  
  internal func cellForTableView( _ tableView: UITableView, atIndexPath indexPath: IndexPath ) -> UITableViewCell {
    
    var cell = UITableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self )
    return cell
  }
}

/**************************** Begin ATModelSource Protocol **********************************/
/**
*  ATableViewDataSource implements the ATModelSource protocol for access to its model data.
*/
extension ATableViewDataSource: ATModelSource {
  func modelForIndexPath( _ indexPath: IndexPath ) -> AnyObject? {
    return fetchedResultsController.object( at: indexPath )
  }
}

/**************************** Begin UITableViewDelegate **********************************/

/**
*  Standard implementation of the UITableViewDataSource protocol. If you don't know what this
*  is you should probably consider doing something else than coding.
*/
extension ATableViewDataSource: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let sectionInfo: AnyObject? = fetchedResultsController?.sections?[ section ]
    
    if sectionInfo != nil {
      let count = sectionInfo!.numberOfObjects
        return count!
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = cellForTableView( tableView, atIndexPath: indexPath )
    
    // and return it
    return cell
  }
}

/**************************** Begin NSFetchedResultsControllerDelegate **********************************/

/**
*  The ATableViewDataSource does implement the NSFetchedResultsControllerDelegate Protocol
*  so it can update the tableView autmatically when changes are made to the data.
*  For more information about NSFetchedResultsControlerDelegate, please consider the documentation.
*/
extension ATableViewDataSource: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case .insert:
      tableView.insertRows( at: [ newIndexPath! ], with: UITableViewRowAnimation.fade )
      
    case .delete:
      tableView.deleteRows( at: [ indexPath! ], with: UITableViewRowAnimation.fade )
      
    case .update:
      // cellForRowAtIndexPath does update the cells?
      tableView.cellForRow( at: indexPath! )
      
    case .move:
      tableView.deleteRows( at: [ indexPath! ], with: UITableViewRowAnimation.fade )
      tableView.insertRows( at: [ newIndexPath! ], with: UITableViewRowAnimation.fade )
    }
    
  }
  
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    
    switch type {
    case NSFetchedResultsChangeType.insert:
      tableView.insertSections( IndexSet(integer: sectionIndex ), with: UITableViewRowAnimation.fade )
    case NSFetchedResultsChangeType.delete:
      tableView.deleteSections( IndexSet(integer: sectionIndex), with: UITableViewRowAnimation.fade )
    default:
      return
        }
    }
}






  
