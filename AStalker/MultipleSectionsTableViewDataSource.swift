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
    
    /// Use a NSFetchedResultsController as the underlying data source.
    internal var fetchedResultsControllers: [NSFetchedResultsController] = [] as! [NSFetchedResultsController]
    
    /// The tableView that is provided with data by this objct
    internal var tableView: UITableView!
    
    init( tableView: UITableView, fetchedResultsControllers: [NSFetchedResultsController<NSFetchRequestResult>] ) {
        
        super.init()
        
        self.fetchedResultsControllers = fetchedResultsControllers
        for frc in self.fetchedResultsControllers{
            frc.delegate = self
        }
        
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
extension MultipleSectionsTableViewDataSource: ATModelSource {
    func modelForIndexPath( _ indexPath: IndexPath ) -> AnyObject? {
        var indexPathWithSectionZero = IndexPath(row: indexPath.row, section: 0)
        return fetchedResultsControllers[indexPath.section].object(at: indexPathWithSectionZero)
    }
}

/**************************** Begin UITableViewDelegate **********************************/

/**
*  Standard implementation of the UITableViewDataSource protocol. If you don't know what this
*  is you should probably consider doing something else than coding.
*/
extension MultipleSectionsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return self.fetchedResultsControllers[section].fetchedObjects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellForTableView( tableView, atIndexPath: indexPath )
        
        // and return it
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
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
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
     func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if type == .update{
            self.controller(controller, didChange: anObject, at: indexPath, for: .delete, newIndexPath: nil)
            self.controller(controller, didChange: anObject, at: nil, for: .insert, newIndexPath: newIndexPath)
            return
        }

        var newIPath : IndexPath!
        if let newIndexPath = newIndexPath{
            for (i, fetchedController) in fetchedResultsControllers.enumerated() {
                if fetchedController === controller {
                    newIPath = IndexPath(row: newIndexPath.row, section: i)
                }
            }
        }
        
        var oldIPath : IndexPath!
        if let indexPath = indexPath{
            for (i, fetchedController) in fetchedResultsControllers.enumerated() {
                if fetchedController === controller {
                    oldIPath = IndexPath(row: indexPath.row, section: i)
                }
            }
        }
        
        switch type {
        case .insert:
            tableView.insertRows( at: [ newIPath! ], with: UITableViewRowAnimation.fade )
            
        case .delete:
            tableView.deleteRows( at: [ oldIPath! ], with: UITableViewRowAnimation.fade )
            
        case .update:
            // cellForRowAtIndexPath does update the cells?
            tableView.cellForRow( at: oldIPath! )
            
        case .move:
            tableView.deleteRows( at: [ oldIPath! ], with: UITableViewRowAnimation.fade )
            tableView.insertRows( at: [ newIPath! ], with: UITableViewRowAnimation.fade )
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

