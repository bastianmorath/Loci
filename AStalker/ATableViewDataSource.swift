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
  internal var fetchedResultsController: NSFetchedResultsController!
  
  /// The tableView that is provided with data by this objct
  internal var tableView: UITableView!
  
  init( tableView: UITableView, fetchedResultsController: NSFetchedResultsController ) {
      
    super.init()
    
    self.fetchedResultsController = fetchedResultsController
    fetchedResultsController.delegate = self
      
    self.tableView = tableView
  }
  
  internal func cellForTableView( tableView: UITableView, atIndexPath indexPath: NSIndexPath ) -> UITableViewCell {
    
    var cell = UITableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self )
    return cell
  }
}

/**************************** Begin ATModelSource Protocol **********************************/
/**
*  ATableViewDataSource implements the ATModelSource protocol for access to its model data.
*/
extension ATableViewDataSource: ATModelSource {
  func modelForIndexPath( indexPath: NSIndexPath ) -> AnyObject? {
    return fetchedResultsController.objectAtIndexPath( indexPath )
  }
}

/**************************** Begin UITableViewDelegate **********************************/

/**
*  Standard implementation of the UITableViewDataSource protocol. If you don't know what this
*  is you should probably consider doing something else than coding.
*/
extension ATableViewDataSource: UITableViewDataSource {
  

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let sectionInfo: AnyObject? = fetchedResultsController?.sections?[ section ]
    
    if sectionInfo != nil {
      let count = sectionInfo!.numberOfObjects
        return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = cellForTableView( tableView, atIndexPath: indexPath )
    
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
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    
    switch type {
    case .Insert:
      tableView.insertRowsAtIndexPaths( [ newIndexPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
      
    case .Delete:
      tableView.deleteRowsAtIndexPaths( [ indexPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
      
    case .Update:
      // cellForRowAtIndexPath does update the cells?
      tableView.cellForRowAtIndexPath( indexPath! )
      
    case .Move:
      tableView.deleteRowsAtIndexPaths( [ indexPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
      tableView.insertRowsAtIndexPaths( [ newIndexPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
    }
    
  }
  
  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    
    switch type {
    case NSFetchedResultsChangeType.Insert:
      tableView.insertSections( NSIndexSet(index: sectionIndex ), withRowAnimation: UITableViewRowAnimation.Fade )
    case NSFetchedResultsChangeType.Delete:
      tableView.deleteSections( NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Fade )
    default:
      return
    }
  }
}






  