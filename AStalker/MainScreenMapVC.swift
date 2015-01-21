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
    
    
    var mapView:MapView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // layout mapView
        var mapHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPad
        } else {
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
        }
        mapView = MapView(frame: CGRectMake(0, 0, self.view.frame.size.width, mapHeight))
        mapView.delegate = self
        self.view.addSubview(mapView )
        
        mapView.zoomIn()
    }
    
    
    

    
    //   Keep track of user: if user changes position center of mapView will change
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        mapView.centerCoordinate = userLocation.location.coordinate
    }
    
    // Gehe zum ShareLocationVC
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        var longitude = 47.35 as Double
        var latitude = 8.68333 as Double
        if let location = self.mapView.userLocation?.location{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        } else {
            println("Couldn't set UserLocation. Random UserLocation set")
        }
        var locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: longitude, latitude: latitude, user: nil)
        
        var shareLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("shareLocationVC") as ShareLocationVC
        shareLocationVC.location = locationToShare
        self.navigationController?.pushViewController(shareLocationVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

