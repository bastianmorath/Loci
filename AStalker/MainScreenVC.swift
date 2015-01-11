//
//  ContainerViewController.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/* This class holds all it's child ViewControllers and their views in ContainerViews */

import Foundation
import UIKit

class MainScreenVC: UIViewController {

    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    
    // Location, welche dem ShareLocationVC übergeben wird
    var locationToShare:Location?
    
    // Containers to hold the child controllers view
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var friendsLocationsContainer: UIView!
    
    // Buttons
    @IBOutlet weak var contactButton: UIButton!
    @IBAction func contactButtonPressed(sender: AnyObject) {
    }
    
    
    @IBOutlet weak var shareYourLocationButton: UIButton!
    @IBAction func shareYourLocationButtonPressed(sender: AnyObject) {
        //var latitude = mapVC.mapView.userLocation.location.coordinate.latitude
        //var longitude = mapVC.mapView.userLocation.location.coordinate.longitude

        locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: 4.1, latitude: 2.9, user: nil)
        
        performSegueWithIdentifier("shareYourLocation", sender: nil)
        
    }
    
    @IBOutlet weak var myLocationsButton: UIButton!
    @IBAction func myLocationsButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var locateMeButton: UIButton!
    @IBAction func locateMeButtonPressed(sender: AnyObject) {
        mapVC.zoomIn()
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup MainScreenMapVC
        mapVC = MainScreenMapVC()
        self.addChildViewController(mapVC)
        mapContainer.addSubview(mapVC.view)
        mapVC.didMoveToParentViewController(self)
        
        // Constraints of mapView (MainScreenMapVC)
        let views = ["mapView":mapVC.view ]
        let metrics = [:]
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat( "H:|[mapView]|", options: nil, metrics: metrics, views: views ) )
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|[mapView]|", options: nil, metrics: metrics, views: views ))
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )
        self.mapContainer.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        // bring Buttons to Front (front of MKMapView)
        mapContainer.bringSubviewToFront(myLocationsButton)
        mapContainer.bringSubviewToFront(shareYourLocationButton)
        mapContainer.bringSubviewToFront(contactButton)
        mapContainer.bringSubviewToFront(locateMeButton)
        
        
        // Setup MainScreenTableVC
        tableVC = MainScreenTableVC()
        self.addChildViewController(tableVC)
        friendsLocationsContainer.addSubview(tableVC.view)
        tableVC.didMoveToParentViewController(self)
        
        // Constraints of tableView (MainScreenTableVC)
        let views2 = ["tableView":tableVC.view ]
        let metrics2 = [:]
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat( "H:|[tableView]|", options: nil, metrics: metrics, views: views2 ) )
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: nil, metrics: metrics, views: views2 ))
        self.friendsLocationsContainer.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        
        //AddressBook Debugging
        //var dict = AddressBook.defaultStore().getContacts(addName: true, addPhoneNumber: true)
        //println(dict)
        
        // setup Buttons
        myLocationsButton.setImage(UIImage(named: "MyLocations"), forState: UIControlState.Normal)
        myLocationsButton.setTitle("", forState: UIControlState.Normal)
        
        
//        contactButton.imageView?.layer.borderWidth=1.0
//        contactButton.imageView?.layer.masksToBounds = false
//        contactButton.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
//        contactButton.imageView?.layer.cornerRadius = 20
//        contactButton.imageView?.clipsToBounds = true
        contactButton.imageView?.backgroundColor = UIColor.whiteColor()
        contactButton.setImage(UIImage(named: "Contacts"), forState: UIControlState.Normal)
        contactButton.setTitle("", forState: UIControlState.Normal)
        
        shareYourLocationButton.setImage(UIImage(named: "SharedLocations"), forState: UIControlState.Normal)
        shareYourLocationButton.setTitle("", forState: UIControlState.Normal)
        
        locateMeButton.setImage(UIImage(named: "LocationPin"), forState: UIControlState.Normal)
        locateMeButton.setTitle("", forState: UIControlState.Normal)

        
        

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
        
        shareLocationVC.location = self.locationToShare!
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


