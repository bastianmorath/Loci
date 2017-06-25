//
//  UITableViewCell+ATTableViewCell.swift
//  Trainer
//
//  Created by Lukas Reichart on 29/12/14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
*  The ATModelSource protocol creates a simple protocol for accessing an objects model objects.
*/
protocol ATModelSource {
    func modelForIndexPath( _ indexPath: IndexPath ) -> AnyObject?
}

/**
*  This extension adds a clean architecture to the UITableViewCell class so we can
*  easily do the cell configuring inside the UITableViewCell subclasses.
*/
extension UITableViewCell {
  
  // Class functions for creating a reuseIdentifier are very handy :D
  class func reuseIdentifier() -> String { return NSStringFromClass( self ).components(separatedBy: ".").last! }
  fileprivate func reuseIdentifier() -> String { return NSStringFromClass( type(of: self) ).components(separatedBy: ".").last! }
  
  /**
  Class func that returns a new UITableViewCell for the given tableView.
  
  :param: tableView   tableView that wantds the cell.
  :param: indexPath   indexPath to add to
  :param: modelSource object that implements the ATModelSource protocol ->
                      This object is used to request the model to configure the cell with.
  
  :returns: the newly created table view cell.
  */
  class func cellForTableView( _ tableView: UITableView, atIndexPath indexPath: IndexPath, withModelSource modelSource: ATModelSource ) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell( withIdentifier: self.reuseIdentifier() )
    
    if cell == nil {
      tableView.register( self, forCellReuseIdentifier: self.reuseIdentifier() )
      cell = (tableView.dequeueReusableCell( withIdentifier: self.reuseIdentifier(), for: indexPath ) )
    }
    
    // configure the cell with the data from the model object
    let model: AnyObject? = modelSource.modelForIndexPath( indexPath )
    cell?.configureWithModelObject( model )
    
    return cell!
  }
  
  /**
  This method configures the cell appearance with the data from the provided model object.
  
  :param: model model to work with.
  */
  func configureWithModelObject( _ model: AnyObject? ) {
    // ... autoconfig not possible because valueForKey is implemented shitty.
  }
  
  
  /**
  This methods may be called to change the cells presentation state. Because
  this function is added in an extension we can not store the actual presentation state
  of a cell. One way to fix this would be to move this function into a separate UITableViewCell
  subclass.
  
  :param: state         the new ATPresentationState
  :param: shouldAnimate indicates whether the changes happes animated or not.
  */
  
  func setPresentationState( _ state: Int, shouldAnimate: Bool ) {
    
  }
}
