//
//  MainScreenDataSource.swift
//  Loci
//
//  Created by Bastian Morath on 16/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class MSSharedLocationsDataSource: ATableViewDataSource{
  
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt.
    var selectedRowIndexPath: IndexPath?
    var coordinateOfMap: CLLocationCoordinate2D?
   
    init( tableView: UITableView) {
        let fetchedResultsController = LocationStore.defaultStore().getMySharedLocationsFC()
        let nib1 = UINib(nibName: "SharedLocationTableViewCell", bundle:nil)

        tableView.register(nib1, forCellReuseIdentifier: SharedLocationTableViewCell.reuseIdentifier())

        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController)
    }
    
    override func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell =  SharedLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as! SharedLocationTableViewCell
        if let selectedRowIndexPath = self.selectedRowIndexPath {
            if selectedRowIndexPath == indexPath{
                cell.expandCellWithCoordinate(self.coordinateOfMap!)
            } else {
                cell.closeCell()
            }
        } else {
            cell.closeCell()
        }
        return cell
    }
}
