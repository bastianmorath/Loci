//
//  MSFriendsDataSource.swift
//  AStalker
//
//  Created by Bastian Morath on 02/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class MSFriendsDataSource: ATableViewDataSource{
    
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt.
    var selectedRowIndexPath: IndexPath = IndexPath()
    var coordinateOfMap: CLLocationCoordinate2D?
    
    init( tableView: UITableView) {
        let fetchedResultsController = LocationStore.defaultStore().getFriendsFC()
        let nib1 = UINib(nibName: "FriendsLocationTableViewCell", bundle:nil)
        
        tableView.register(nib1, forCellReuseIdentifier: FriendsLocationTableViewCell.reuseIdentifier())
        
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController)
    }
    
    override func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell =  FriendsLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as! FriendsLocationTableViewCell
        if selectedRowIndexPath == indexPath {
            cell.expandCellWithCoordinate(self.coordinateOfMap!)
        } else {
            cell.closeCell()
        }
        return cell
    }
}
