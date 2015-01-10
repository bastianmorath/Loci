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
    var items: [String]!
    
    override func loadView() {
      
        // layout tableView
        tableView = UITableView()
        self.view = UIView()
        self.view.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(tableView)
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )

        // setup tableView
        tableView.delegate = self
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "MainScreenTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "cell")
        
        items = ["We", "Swift"]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    // MARK:- Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // MARK:- Delegates
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel!.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("cell selected")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}