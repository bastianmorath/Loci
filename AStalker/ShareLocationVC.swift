//
//  ShareLocationVC.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import CoreLocation

class ShareLocationVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Strassen- und Ortslabel der Location
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    //DataSource des TableViews
    var shareLocationDataSource: ShareLocationDataSource!
    
    //Hier wird das Location-Objekt gespeichert, welches vom MainVC übergeben wird
    var location:Location!
    
    var shareButton: UIButton?
    
    var animationController = HideMapAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.streetLabel.font = UIFont.ATBoldFont()
        self.placeLabel.font = UIFont.ATFont()
        
        
        // Strasse und Ort bestimmen
        var location = CLLocation(latitude: self.location.latitude.doubleValue, longitude: self.location.longitude.doubleValue)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                var city = pm.addressDictionary["City"] as String
                var street = pm.addressDictionary["Street"] as String
                
                self.streetLabel.text = street
                self.placeLabel.text = city
            }
            else {
                println("Problem with the data received from geocoder")
            }
        })
        
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
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var label: UILabel = UILabel(frame: CGRectMake(28, -4, 40, 50))
        label.font = UIFont.ATFont()
        label.text = "Share"
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedUser = self.shareLocationDataSource.modelForIndexPath(indexPath) as User
        var cell = tableView.cellForRowAtIndexPath(indexPath) as ShareLocationTableViewCell
        
        if location!.sharedUsers.containsObject(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus locations.sharedUsers
            var mutableSet = NSMutableSet(set: location.sharedUsers)
            mutableSet.removeObject(selectedUser)
            location.sharedUsers = NSSet(set: mutableSet)
        } else {
            //Füge den User bei lcoation.sharedUsers hinzu und Selecte ihn im View(roter Checkmark-View)
            location.sharedUsers = location.sharedUsers.setByAddingObject(selectedUser)
        }
        cell.checkboxButton.isChecked = !cell.checkboxButton.isChecked
    }
    
    func sharePressed() {
        //Add Location to localUser.sharedLocations
        var mutableSet = LocationStore.defaultStore().getLocalUser()?.sharedLocations as NSMutableSet
        mutableSet.addObject(location)
        LocationStore.defaultStore().getLocalUser()?.sharedLocations = mutableSet
        println("\(self.location.sharedUsers.count) Personen hinzugefügt")
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}