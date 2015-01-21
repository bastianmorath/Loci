//
//  MainScreenDataSource.swift
//  AStalker
//
//  Created by Bastian Morath on 16/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class MSSharedLocationsDataSource: ATableViewDataSource{
    init( tableView: UITableView) {
        let fetchedResultsController = LocationStore.defaultStore().getMySharedLocationsFC()
        let nib = UINib(nibName: "FriendsLocationTableViewCell", bundle:nil)

        tableView.registerNib(nib, forCellReuseIdentifier: FriendsLocationTableViewCell.reuseIdentifier() )
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController )
    }
    
    override func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  FriendsLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as FriendsLocationTableViewCell
        return cell
    }
}
