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
    
    override func loadView() {
      
        // layout tableView
        tableView = UITableView()
        self.view = UIView()
        self.view.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(tableView)
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )

        // setup tableView
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "MainScreenTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "cell")
        
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
        var cell:MainScreenTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as MainScreenTableViewCell
        
        // set properties to cell
        cell.userNameLabel.text = "Aleksandar Papez"
        cell.timeLabel.text = "12:45"
        cell.dateLabel.text = "10. Januar"
        cell.addressLabel.text = "Im Werk 11, Uster"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("cell selected")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}