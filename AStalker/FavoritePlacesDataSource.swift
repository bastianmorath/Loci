//
//  FavoritePlacesDataSoruce.swift
//  AStalker
//
//  Created by Bastian Morath on 04/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit
class FavoritePlacesDataSource: ATableViewDataSource {
    
    // View des FavoritePlacesVC
    var view: UIView!
    
    var currentTableView: UITableView!
    
    init(tableView: UITableView, view: UIView) {
        let fetchedResultsController = LocationStore.defaultStore().getFavoriteLocationsFC()
        let nib1 = UINib(nibName: "FavoritePlacesTableViewCell", bundle:nil)
        
        tableView.register(nib1, forCellReuseIdentifier: FavoritePlacesTableViewCell.reuseIdentifier())
        self.currentTableView = tableView
        self.view = view
        super.init(tableView: tableView, fetchedResultsController: fetchedResultsController)
    }
    
    override func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        var cell =  FavoritePlacesTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self ) as! FavoritePlacesTableViewCell
        cell.view = self.view
        cell.tableView = self.currentTableView
        return cell
    }
}
