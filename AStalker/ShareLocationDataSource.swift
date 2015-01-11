//
//  ShareLocationDataSource.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ShareLocationDataSource: ATableViewDataSource{
    init( tableView: UITableView, user: LocalUser ) {
        let fetchedResultsController = LocationStore.defaultStore().FetchedResultsControllerOfUser(user)
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController )
    }
    
    override func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self )
    }
}