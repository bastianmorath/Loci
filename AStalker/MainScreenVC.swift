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
     var contactButton: UIButton!
     func contactButtonPressed(sender: AnyObject) {
    }
    
    
     var shareYourLocationButton: UIButton!
     func shareYourLocationButtonPressed(){
        //var latitude = mapVC.mapView.userLocation.location.coordinate.latitude
        //var longitude = mapVC.mapView.userLocation.location.coordinate.longitude

        locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: 4.1, latitude: 2.9, user: nil)
        
        performSegueWithIdentifier("shareYourLocation", sender: nil)
        
    }
    
     var myLocationsButton: UIButton!
     func myLocationsButtonPressed(sender: AnyObject) {
    }
    
     var locateMeButton: UIButton!
     func locateMeButtonPressed(sender: AnyObject) {
        mapVC.zoomIn()
    }
    
    
    //TransitionManager für CustomSegue
    let transitionManager = TransitionManager()

    
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
        myLocationsButton = UIButton.ATButton(.MultipleLocations, color: .White)
        myLocationsButton.positionButtonToLocation(.TopLeft)
        self.mapContainer.addSubview(myLocationsButton)
        
        contactButton = UIButton.ATButton(.Contact, color: .White)
        contactButton.positionButtonToLocation(.TopRight)
        self.mapContainer.addSubview(contactButton)

        shareYourLocationButton = UIButton.ATButton(.ContactLocation, color: .White)
        shareYourLocationButton.positionButtonToLocation(.BottomLeft)
        self.mapContainer.addSubview(shareYourLocationButton)

        locateMeButton = UIButton.ATButton(.SingleLocation, color: .White)
        locateMeButton.positionButtonToLocation(.BottomRight)
        self.mapContainer.addSubview(locateMeButton)
        

        self.shareYourLocationButtonPressed()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
        
        shareLocationVC.location = self.locationToShare!

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


