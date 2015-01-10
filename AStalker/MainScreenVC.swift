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

    // Containers to hold the child controllers view
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var friendsLocationsContainer: UIView!
    
    // Buttons
    @IBOutlet weak var contactButton: UIButton!
    @IBAction func contactButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var shareYourLocationButton: UIButton!
    @IBAction func shareYourLocationButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var myLocationsButton: UIButton!
    @IBAction func myLocationsButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var locateMeButton: UIButton!
    @IBAction func locateMeButtonPressed(sender: AnyObject) {
        mapVC.zoomIn()
    }
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    

    
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
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )
        self.friendsLocationsContainer.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        
        //AddressBook Debugging
        var dict = AddressBook.defaultStore().getContacts(addName: true, addPhoneNumber: true)
        println(dict)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


