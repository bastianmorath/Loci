//
//  ShareLocationVC.swift
//  Loci
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import CoreLocation

class ShareLocationVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Strassen- und Ortslabel der Location
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    //DataSource des TableViews
    var shareLocationDataSource: ShareLocationDataSource!
    
    //Hier wird das Location-Objekt gespeichert, welches vom MainVC übergeben wird
    var location:Location!
    
    var shareButton: UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.streetLabel.font = UIFont.ATBoldFont()
        self.placeLabel.font = UIFont.ATFont()
        
        
        // Strasse und Ort bestimmen
        
        self.streetLabel.text = self.location.getStreet()
        self.placeLabel.text = self.location.getCity()
        
        //ShareButton
        self.shareButton = UIButton.ATButton(UIButton.ATButtonType.Share, color: UIButton.ATColor.White)
        if let button = shareButton{
            button.addTarget(self, action: "sharePressed", forControlEvents:UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.TopRight)
        }
        
        // TableView DataSource definieren
        let localUser = (LocationStore.defaultStore().getLocalUser())
        shareLocationDataSource = ShareLocationDataSource(tableView: tableView, user: localUser!, location: self.location )
        tableView.dataSource = shareLocationDataSource
        
        self.tableView.frame = CGRectMake(0, Constants.topSpace, Constants.screenWidth, Constants.screenHeight-2 * Constants.topSpace)
    }
    
    
    //MARK:- Table View Delegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var label: UILabel = UILabel(frame: CGRectMake(31
            , 40, 40, 50))
        label.font = UIFont.ATFont()
        label.text = "Share"
        headerView.addSubview(label)
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedUser = self.shareLocationDataSource.modelForIndexPath(indexPath) as User
        var cell = tableView.cellForRowAtIndexPath(indexPath) as ShareLocationTableViewCell
        var dataSource = self.tableView.dataSource as ShareLocationDataSource
        if dataSource.selectedUserSet.containsObject(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus dem userSet
            dataSource.selectedUserSet.removeObject(selectedUser)
        } else {
            //Füge den User bei lcoation.sharedUsers hinzu und Selecte ihn im View(roter Checkmark-View)
            dataSource.selectedUserSet.addObject(selectedUser)
        }
        cell.checkboxButton.isChecked = !cell.checkboxButton.isChecked
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Constants.kCellHeight
    }
    
    //MARK:- Button Handlers
    func sharePressed() {
        self.location.sharedUsers = (self.tableView.dataSource as ShareLocationDataSource).selectedUserSet

        //Add Location to localUser.sharedLocations
        var mutableSet = LocationStore.defaultStore().getLocalUser()?.sharedLocations as NSMutableSet
        mutableSet.addObject(location)
        LocationStore.defaultStore().getLocalUser()?.sharedLocations = mutableSet
        println("\(self.location.sharedUsers.count) Personen hinzugefügt")
        
        self.dismissViewController()
    }
}