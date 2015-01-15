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

class MainScreenTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // layout tableView
        tableView = UITableView()
        self.view.addSubview(tableView)
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        // setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        let nibName = UINib(nibName: "FriendsLocationTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "FriendsLocationTableViewCell")

        let nibNameHeader = UINib(nibName: "FriendsLocationHeaderTableViewCell", bundle:nil)
        self.tableView.registerNib(nibNameHeader, forCellReuseIdentifier: "FriendsLocationHeaderTableViewCell")

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    // MARK:- Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // MARK:- Delegates
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FriendsLocationTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("FriendsLocationTableViewCell") as FriendsLocationTableViewCell
        var headerCell:FriendsLocationHeaderTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("FriendsLocationHeaderTableViewCell") as FriendsLocationHeaderTableViewCell
        if indexPath.row == 0 {
            return headerCell
        }
        // set properties to cell
        cell.userNameLabel.text = "Aleksandar Papez"
        cell.timeLabel.text = "12:45"
        cell.dateLabel.text = "10. Januar"
        cell.addressLabel.text = "Im Werk 11, Uster"
        cell.imageIconView.image = UIImage(named: "BigLocationPin")
        cell.imageIconView.backgroundColor = UIColor.whiteColor()
    
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("cell selected")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // Header Cell
            return 60
        } else {
            return 55
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}