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
    
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tabelVC: MainScreenTableVC!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup MainScreenMapVC
        mapVC = MainScreenMapVC()
        self.addChildViewController(mapVC)
        mapContainer.addSubview(mapVC.view)
        mapVC.didMoveToParentViewController(self)
        
        let views = ["mapView":mapVC.view ]
        let metrics = [:]
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat( "H:|[mapView]|", options: nil, metrics: metrics, views: views ) )
        self.view.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat("V:|[mapView]|", options: nil, metrics: metrics, views: views ))
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )
        self.mapContainer.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        // add Observer
        
        // Setup MainScreenTableVC
        tabelVC = MainScreenTableVC()
        self.addChildViewController(tabelVC)
        friendsLocationsContainer.addSubview(tabelVC.view)
        tabelVC.didMoveToParentViewController(self)
        
        
        
        //AddressBook Debugging
        var dict = AddressBook.defaultStore().getContacts(addName: true, addPhoneNumber: true)
        println(dict)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


