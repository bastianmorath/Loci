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
    
    // MARK: - Properies und Variabeln
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    
    // Location, welche dem ShareLocationVC übergeben wird
    var locationToShare:Location?
    
    // Containers to hold the child controllers view
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var friendsLocationsContainer: UIView!
    
    // Buttons
    
    //Zeigt alle Kontakte des Users an, insbesondere wo diese sich befinden und wann sie dort waren
    var contactButton: UIButton!
    
    /// Der User shared seine Location und kann auswählen, mit welchen Kontakten er das machen will
    var shareYourLocationButton: UIButton!
    
    /// Zeigt die Favoriten/Meist besuchten Locations vom Nutzer an. Dort sieht man auch, wie lange man an einer Location war.
    var myLocationsButton: UIButton!
    
    /// Die momentane Location des Users wird auf der Karte angezeigt
    var locateMeButton: UIButton!
    
    
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
        
        // Setup Buttons
        myLocationsButton = UIButton.ATButton(.MultipleLocations, color: .White)
        myLocationsButton.addTarget(self, action: "myLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(myLocationsButton)
        myLocationsButton.positionButtonToLocation(.TopLeft)
        
        contactButton = UIButton.ATButton(.Contact, color: .White)
        contactButton.addTarget(self, action: "contactButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(contactButton)
        contactButton.positionButtonToLocation(.TopRight)
        
        shareYourLocationButton = UIButton.ATButton(.ContactLocation, color: .Grey)
        shareYourLocationButton.addTarget(self, action: "shareYourLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.friendsLocationsContainer.addSubview(shareYourLocationButton)
        shareYourLocationButton.positionButtonToLocation(.TopHalfLeft)
        
        locateMeButton = UIButton.ATButton(.SingleLocation, color: .White)
        locateMeButton.addTarget(self, action: "locateMeButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(locateMeButton)
        locateMeButton.positionButtonToLocation(.BottomRight)
}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shareYourLocation" {
            var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
            
            shareLocationVC.location = self.locationToShare!
        }
    }
    
    // MARK: - Button Handling
    
    func locateMeButtonPressed() {
        mapVC.zoomIn()
    }
    
    func myLocationsButtonPressed() {
        
    }
    
    func shareYourLocationButtonPressed(){
        var latitude = mapVC.mapView.userLocation?.location?.coordinate.latitude
        var longitude = mapVC.mapView.userLocation?.location?.coordinate.longitude
        
        if longitude == longitude && latitude == latitude{
            locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: 4.1, latitude: 2.9, user: nil)
            performSegueWithIdentifier("shareYourLocation", sender: nil)
        }
    }
    
    func contactButtonPressed(sender: AnyObject) {
        
    }
    
}


