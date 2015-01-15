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
    

    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    let kAspectRatioMapToTableViewIPad: CGFloat = 1.04


    
    
    // MARK: - Properies und Variabeln
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    
    // Location, welche dem ShareLocationVC übergeben wird
    var locationToShare:Location?
    
    // Containers to hold the child controllers view
    var mapContainer: UIView!
    var tableViewContainer: UIView!
    
    
    
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
        var mapHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPad
        } else {
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
        }
        self.mapContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, mapHeight))
        self.view.addSubview(self.mapContainer)
        mapContainer.addSubview(mapVC.view)
        mapVC.didMoveToParentViewController(self)
        
        
       //  Setup TableViewController
        tableVC = MainScreenTableVC()
        self.addChildViewController(tableVC)
        var tableViewHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            tableViewHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPad
        } else {
            tableViewHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
        }
        self.tableViewContainer = UIView(frame: CGRectMake(0, tableViewHeight, self.view.frame.size.width, self.view.frame.height - tableViewHeight))
        self.view.addSubview(self.tableViewContainer)
        tableViewContainer.addSubview(tableVC.view)
        tableVC.didMoveToParentViewController(self)
        
        
        // Setup Buttons
        myLocationsButton = UIButton.ATButton(.MultipleLocations, color: .White)
        myLocationsButton.addTarget(self, action: "myLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(myLocationsButton)
        myLocationsButton.positionButtonToLocation(.TopLeft)
        
        contactButton = UIButton.ATButton(.Contact, color: .White)
        contactButton.addTarget(self, action: "contactButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(contactButton)
        contactButton.positionButtonToLocation(.TopRight)
        
        shareYourLocationButton = UIButton.ATButton(.ContactLocation, color: .Grey)
        shareYourLocationButton.addTarget(self, action: "shareYourLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(shareYourLocationButton)
        shareYourLocationButton.positionButtonToLocation(.BottomLeft)
        
        locateMeButton = UIButton.ATButton(.SingleLocation, color: .White)
        locateMeButton.addTarget(self, action: "locateMeButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(locateMeButton)
        locateMeButton.positionButtonToLocation(.BottomRight)
        
        
}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showShareYourLocationVCSegue" {
            var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
            
            shareLocationVC.location = self.locationToShare!
        }
        if segue.identifier == "showFriendsVCSegue" {
            var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
            
            shareLocationVC.location = self.locationToShare!
        }
    }
    
    // MARK: - Button Handling
    
    func locateMeButtonPressed() {
        mapVC.zoomIn()
    }
    
    func myLocationButtonPressed() {
        
    }
    
    func shareYourLocationButtonPressed(){
        var latitude = mapVC.mapView.userLocation?.location?.coordinate.latitude
        var longitude = mapVC.mapView.userLocation?.location?.coordinate.longitude
        
        if longitude == longitude && latitude == latitude{
            locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: 4.1, latitude: 2.9, user: nil)
            
            var shareLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("shareLocationVC") as ShareLocationVC
            self.navigationController?.pushViewController(shareLocationVC, animated: true)
        }
    }
    
    func contactButtonPressed() {
        var addFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addFriendsVC") as AddFriendsVC
        self.navigationController?.pushViewController(addFriendsVC, animated: true)

    }
}


