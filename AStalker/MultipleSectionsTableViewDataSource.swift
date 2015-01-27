//
//  MultipleSectionsTableViewDataSource.swift
//  Loci
//
//  Created by Bastian Morath on 19/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
*  The ATableViewDataSource class is used as a DataSource for UITableViews.
*  It uses a NSFetchedResultsController to retrieve the data to display and autmatically
*  updating the table view as changes to the data happend.
*/

// Arrays!!
class MultipleSectionsTableViewDataSource:NSObject{
    
    /// Use a NSFetch2edResultsController as the underlying data source.
    internal var fetchedResultsControllers: [NSFetchedResultsController] = []
    
    /// The tableView that is provided with data by this objct
    internal var tableView: UITableView!
    
    init( tableView: UITableView, fetchedResultsControllers: [NSFetchedResultsController] ) {
        
        super.init()
        
        self.fetchedResultsControllers = fetchedResultsControllers
        for frc in self.fetchedResultsControllers{
            frc.delegate = self
        }
        
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
extension MultipleSectionsTableViewDataSource: ATModelSource {
    func modelForIndexPath( indexPath: NSIndexPath ) -> AnyObject? {
        var indexPathWithSectionZero = NSIndexPath(forRow: indexPath.row, inSection: 0)
        return fetchedResultsControllers[indexPath.section].objectAtIndexPath(indexPathWithSectionZero)
    }
}

/**************************** Begin UITableViewDelegate **********************************/

/**
*  Standard implementation of the UITableViewDataSource protocol. If you don't know what this
*  is you should probably consider doing something else than coding.
*/
extension MultipleSectionsTableViewDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return self.fetchedResultsControllers[section].fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = cellForTableView( tableView, atIndexPath: indexPath )
        
        // and return it
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsControllers.count
    }
    
}

/**************************** Begin NSFetchedResultsControllerDelegate **********************************/

/**
*  The ATableViewDataSource does implement the NSFetchedResultsControllerDelegate Protocol
*  so it can update the tableView autmatically when changes are made to the data.
*  For more information about NSFetchedResultsControlerDelegate, please consider the documentation.
*/
extension MultipleSectionsTableViewDataSource: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        var newIPath : NSIndexPath!
        if let newIndexPath = newIndexPath{
            for (i, fetchedController) in enumerate(fetchedResultsControllers) {
                if fetchedController === controller {
                    newIPath = NSIndexPath(forRow: newIndexPath.row, inSection: i)
                }
            }
        }
        
        var oldIPath : NSIndexPath!
        if let indexPath = indexPath{
            for (i, fetchedController) in enumerate(fetchedResultsControllers) {
                if fetchedController === controller {
                    oldIPath = NSIndexPath(forRow: indexPath.row, inSection: i)
                }
            }
        }

    
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths( [ newIPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
            
        case .Delete:
            tableView.deleteRowsAtIndexPaths( [ oldIPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
            
        case .Update:
            // cellForRowAtIndexPath does update the cells?
            tableView.cellForRowAtIndexPath( oldIPath! )
            
        case .Move:
            tableView.deleteRowsAtIndexPaths( [ oldIPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
            tableView.insertRowsAtIndexPaths( [ newIPath! ], withRowAnimation: UITableViewRowAnimation.Fade )
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

