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
    var location:SharedLocation!
    
    var shareButton: LociButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.streetLabel.font = UIFont.ATBoldFont()
        self.placeLabel.font = UIFont.ATFont()
        
        
        // Strasse und Ort bestimmen
        
        self.streetLabel.text = self.location.getStreet()
        self.placeLabel.text = self.location.getCity()
        
        //ShareButton
        self.shareButton = LociButton(type:.share, color:.white)
        if let button = shareButton{
            button.addTarget(self, action: #selector(ShareLocationVC.sharePressed), for:UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.topRight)
        }
        
        // TableView DataSource definieren
        let localUser = (LocationStore.defaultStore().getLocalUser())
        shareLocationDataSource = ShareLocationDataSource(tableView: tableView, user: localUser!, location: self.location )
        tableView.dataSource = shareLocationDataSource
    }
    
    //MARK:- Table View Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: Constants.headerHeight-30))
        headerView.backgroundColor = UIColor.clear
        let label: UILabel = UILabel(frame: CGRect(x: 31
            , y: Constants.headerHeight - 30, width: 40, height: 15))
        label.font = UIFont.ATFont()
        label.text = "Share"
        headerView.addSubview(label)
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser = self.shareLocationDataSource.modelForIndexPath(indexPath) as! User
        var cell = tableView.cellForRow(at: indexPath) as! ShareLocationTableViewCell
        var dataSource = self.tableView.dataSource as! ShareLocationDataSource
        if dataSource.selectedUserSet.contains(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus dem userSet
            dataSource.selectedUserSet.remove(selectedUser)
        } else {
            //Füge den User bei lcoation.sharedUsers hinzu und Selecte ihn im View(roter Checkmark-View)
            dataSource.selectedUserSet.add(selectedUser)
        }
        cell.checkboxButton.isChecked = !cell.checkboxButton.isChecked
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kCellHeight
    }
    
    //MARK:- Button Handlers
    func sharePressed() {
        self.location.sharedUsers = (self.tableView.dataSource as! ShareLocationDataSource).selectedUserSet
        
        //Add Location to localUser.sharedLocations
        let mutableSet = LocationStore.defaultStore().getLocalUser()?.sharedLocations as! NSMutableSet
        mutableSet.add(location)
        LocationStore.defaultStore().getLocalUser()?.sharedLocations = mutableSet
        print("\(self.location.sharedUsers.count) Personen hinzugefügt")
        
        self.dismissViewController()
    }
}
