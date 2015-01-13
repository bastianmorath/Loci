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

class AddFriendsDataSource: ATableViewDataSource, UITableViewDelegate{
    
    var location: Location?
    init( tableView: UITableView, user: LocalUser, location: Location? = nil) {
        self.location = location
        let fetchedResultsController = LocationStore.defaultStore().FetchedResultsControllerOfUser(user)
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController )
    }
    
    
    override func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  AddFriendsTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as ShareLocationTableViewCell
        var user = self.modelForIndexPath(indexPath) as User
        return cell
    }
    
    
}