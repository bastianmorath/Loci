//
//  ShareLocationVC.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import CoreLocation

class ShareLocationVC: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
   
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var shareLocationDataSource: ShareLocationDataSource!
    
    //Hier wird das Location-Objekt gespeichert, welches vom MainVC übergeben wird
    var location:Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.streetLabel.font = UIFont.ATBoldFont()
        self.placeLabel.font = UIFont.ATFont()
        
        
        var location = CLLocation(latitude: self.location.longitude.doubleValue, longitude: self.location.longitude.doubleValue) //changed!!!
        println(location)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            if error != nil {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                println(pm.locality)
                println(pm.thoroughfare)
                println(pm.postalCode)

            }
            else {
                println("Problem with the data received from geocoder")
            }
        })
        
        
        let localUser = (LocationStore.defaultStore().getLocalUser())
        shareLocationDataSource = ShareLocationDataSource(tableView: tableView, user: localUser!)
        tableView.dataSource = shareLocationDataSource
}

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        var selectedUser = self.shareLocationDataSource.modelForIndexPath(indexPath) as User
        if location!.sharedUsers.containsObject(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus locations.sharedUsers
           var mutableSet = NSMutableSet(set: location.sharedUsers)
            mutableSet.removeObject(selectedUser)
            location.sharedUsers = NSSet(set: mutableSet)
        } else {
            //Füge den User bei lcoation.sharedUsers hinzu und Selecte ihn im View(roter Checkmark-View)
            location.sharedUsers = location.sharedUsers.setByAddingObject(selectedUser)
            var cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.contentView.addSubview(self.redCheckmarkView())
        }
        println("Anzahl ausgewählte KOntakte: \(location.sharedUsers.count)")
    }
    
    
    @IBAction func sharePressed(sender: AnyObject) {
        //location.sharedUsers = NSSet(array: userToShareArray)
        // Add Location to localUser.sharedLocations
    }
    
    //Roter Checkmark-View
    func redCheckmarkView() -> UIView {
        var view = UIImageView(frame: CGRectMake(26, 8, 35, 35))
        view.backgroundColor = UIColor(red: 236, green: 28, blue: 36, alpha: 1)
        view.image = UIImage(named: "checkmark.png")
        
        return view
    }

}