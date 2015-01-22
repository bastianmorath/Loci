//
//  MainScreenDataSource.swift
//  AStalker
//
//  Created by Bastian Morath on 16/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class MSSharedLocationsDataSource: ATableViewDataSource{
  
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt.
    var selectedRowIndexPath: NSIndexPath = NSIndexPath()
    var coordinateOfMap: CLLocationCoordinate2D?
   
    init( tableView: UITableView) {
        let fetchedResultsController = LocationStore.defaultStore().getMySharedLocationsFC()
        let nib1 = UINib(nibName: "FriendsLocationTableViewCell", bundle:nil)

        tableView.registerNib(nib1, forCellReuseIdentifier: FriendsLocationTableViewCell.reuseIdentifier())

        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController)
    }
    
    override func cellForTableView(tableView: UITableView, atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  FriendsLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as FriendsLocationTableViewCell
        if selectedRowIndexPath == indexPath {
            cell.expandCellWithCoordinate(self.coordinateOfMap!)
        } else {
            cell.closeCell()
        }
        
        return cell
    }
}
