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
    
    // Gibt an, ob der TableView ausgeklappt ist oder nicht.
    var tableViewIsExtended = false
    
    // Height of TableView
    var tableViewHeight:CGFloat {
        get{
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
                return self.view.frame.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPad
            } else {
                return self.view.frame.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
            }
        }
    }
    
    
    
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
        
        //
        self.tableViewContainer = UIView(frame: CGRectMake(0, self.view.frame.height-self.tableViewHeight, self.view.frame.size.width, self.tableViewHeight))
        
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
        self.view.addSubview(contactButton)
        contactButton.positionButtonToLocation(.TopRight)
        
        shareYourLocationButton = UIButton.ATButton(.ContactLocation, color: .Grey)
        shareYourLocationButton.addTarget(self, action: "shareYourLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.tableViewContainer.addSubview(shareYourLocationButton)
        shareYourLocationButton.positionButtonToLocation(.TopHalfLeft)
        
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
        var latitude = mapVC.mapView.userLocation?.location?.coordinate.latitude
        var longitude = mapVC.mapView.userLocation?.location?.coordinate.longitude
        
        if let longitude = longitude{
            if let latitude = latitude{
                locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: longitude, latitude: latitude, user: nil)
                
                var shareLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("shareLocationVC") as ShareLocationVC
                shareLocationVC.location = locationToShare
                self.navigationController?.pushViewController(shareLocationVC, animated: true)
            }
        }
    }
    
    func shareYourLocationButtonPressed(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * 55 - self.tableViewHeight
            
            let topSpace = 100 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            
            if self.tableViewIsExtended{
                // Button grau einfärben
                self.shareYourLocationButton.backgroundColor = UIColor.GreyColor()
                self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            } else {
                // Button rot einfärben
                self.shareYourLocationButton.backgroundColor = UIColor.RedColor()
                self.view.backgroundColor = UIColor.RedColor()
                self.view.frame = CGRectMake(0, -transitionConstant, self.view.frame.width, self.view.frame.height+2*transitionConstant)
            }
            
        })
        
        self.tableViewIsExtended = !self.tableViewIsExtended
    }
    
    func contactButtonPressed() {
        var addFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addFriendsVC") as AddFriendsVC
        self.navigationController?.pushViewController(addFriendsVC, animated: true)
        
    }
}


