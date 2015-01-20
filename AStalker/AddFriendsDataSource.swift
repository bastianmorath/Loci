//
//  AddFriendsDataSource.swift
//  AStalker
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddFriendsDataSource: MultipleSectionsTableViewDataSource{
    
    
    init( tableView: UITableView, user: LocalUser) {
        let fetchedResultsControllerFriends = LocationStore.defaultStore().getFriendsFC()
        let fetchedResultsControllerNoneFriends = LocationStore.defaultStore().getUsersWithoutFriendsFC()
        
        super.init(tableView: tableView, fetchedResultsControllers: [fetchedResultsControllerFriends, fetchedResultsControllerNoneFriends] )
    }
    
    override func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  AddFriendsTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as AddFriendsTableViewCell
        var user = self.modelForIndexPath(indexPath) as User
        return cell
    }
    
  
}