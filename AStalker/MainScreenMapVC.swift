//
//  MapVC.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/**
*  This Controller controlls the mapContainer View in the MainScreenVC 
*  The MKMapView displays the users position
*/

import Foundation
import UIKit
import MapKit
import CoreLocation


class MainScreenMapVC: UIViewController, MKMapViewDelegate {
    
    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    let kAspectRatioMapToTableViewIPad: CGFloat = 1.04
    
    
    var mapView:MKMapView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // layout mapView
        var mapHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPad
        } else {
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
        }
        mapView = MKMapView(frame: CGRectMake(0, 0, self.view.frame.size.width, mapHeight))
        self.view.addSubview(mapView )

        // initialize Map
        mapView.removeAnnotations(self.mapView.annotations)
        mapView.mapType = MKMapType.Standard
        mapView.delegate = self
        mapView.rotateEnabled = false
        //mapView.setTranslatesAutoresizingMaskIntoConstraints( false )
        
        //show user location
        mapView.showsUserLocation = true
        zoomIn()
    }


    
    //  adjust Region of mapView
    func zoomIn() {
        var userLocation = mapView.userLocation
        
        if let userLocation = userLocation {
            let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
            let adjustedRegion = mapView.regionThatFits(region)
            mapView.setRegion(adjustedRegion, animated: false)

        }
 
    }
    
    
    //   Keep track of user: if user changes position center of mapView will change
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        mapView.centerCoordinate = userLocation.location.coordinate
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

