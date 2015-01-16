//
//  TableVC.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/**
*  This Controller controlls the tableContainer View in the MainScreenVC
*  The TableView shows the locations of the users friends
*/

import Foundation
import UIKit

class MainScreenTableVC: UIViewController, UITableViewDelegate  {
    
    var tableView:UITableView!
    
    //DataSource des TableViews
    var sharedLocationsDataSource: MSSharedLocationsDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView.delegate = self
        
        // layout tableView
        self.view.addSubview(tableView)
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        sharedLocationsDataSource = MSSharedLocationsDataSource(tableView: self.tableView)
        self.tableView.dataSource = sharedLocationsDataSource
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var sharedLocationsLabel: UILabel = UILabel(frame: CGRectMake(28, -4, 40, 50))
        sharedLocationsLabel.font = UIFont.ATFont()
        sharedLocationsLabel.text = "Shared Locations"
        headerView.addSubview(sharedLocationsLabel)
        
        //TODO: Diesem label Constraints hinzufügen
        var timeLabel: UILabel = UILabel(frame: CGRectMake(280, -4, 40, 50))
        timeLabel.font = UIFont.ATFont()
        timeLabel.text = "Time"
        headerView.addSubview(timeLabel)
        
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
}