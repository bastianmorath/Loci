//
//  ShareLocationDataSource.swift
//  Loci
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit


class ShareLocationDataSource: ATableViewDataSource{
    var selectedUserSet = NSMutableSet()
    var location: SharedLocation?
    init( tableView: UITableView, user: LocalUser, location: SharedLocation? = nil) {
        self.location = location
        let fetchedResultsController = LocationStore.defaultStore().getUsersFC()
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController )
    }
    
    override func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell =  ShareLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as! ShareLocationTableViewCell
        var user = self.modelForIndexPath(indexPath) as! User
        if self.selectedUserSet.contains(user){
            cell.checkboxButton.isChecked = true
        } else {
            cell.checkboxButton.isChecked = false
        }
        return cell
    }
}
