//
//  ShareLocationVC.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class ShareLocationVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
   
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    var shareLocationDataSource: ShareLocationDataSource!
    
    //Hier wird das Location-Objekt gespeichert, welches vom MainVC übergeben wird
    //var location = Location()
    
    //Dieser Array speichert die angeklickten User
    var userToShareArray: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Create DebugObjects
        LocationStore.defaultStore().createDebugUsers()
        LocationStore.defaultStore().createDebugLocalUser()
        
        let localUser = (LocationStore.defaultStore().getLocalUser())
        var name = localUser.name
    
        
        self.streetLabel.font = UIFont.ATBoldFont()
        self.placeLabel.font = UIFont.ATFont()

        shareLocationDataSource = ShareLocationDataSource(tableView: tableView, user: localUser)
        tableView.dataSource = shareLocationDataSource
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        
    }
    
    
    @IBAction func sharePressed(sender: AnyObject) {
        //location.sharedUsers = NSSet(array: userToShareArray)
        // Add Location to localUser.sharedLocations
    }
}
