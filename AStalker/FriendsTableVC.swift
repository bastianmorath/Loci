//
//  FriendsTableVCTableViewController.swift
//  AStalker
//
//  Created by Bastian Morath on 02/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class FriendsTableVC: LIViewController, UITableViewDelegate, UIScrollViewDelegate {

    
    //Wird vom MainScreenVC gesetzt; Zeigt, ob der TableView ausgeklappt ist oder nicht
    var tableViewIsExtended = false
    
    
    //DataSource des TableViews
    var friendsDataSource: MSFriendsDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsDataSource = MSFriendsDataSource(tableView: self.tableView)
        self.tableView.dataSource = friendsDataSource
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        headerView.backgroundColor = UIColor.clear
 
        let sharedLocationsLabel: UILabel = UILabel(frame: CGRect(x: 32, y: 58, width: 100, height: 15))
        sharedLocationsLabel.font = UIFont.ATFont()
        sharedLocationsLabel.text = "Friends"
        headerView.addSubview(sharedLocationsLabel)
        
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func reloadData(){
        friendsDataSource = MSFriendsDataSource(tableView: self.tableView)
        self.tableView.dataSource = friendsDataSource
        self.tableView.reloadData()
    }
    
    
    
}
