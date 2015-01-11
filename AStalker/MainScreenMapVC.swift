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
    
    var mapView:MKMapView!
    
    override func loadView() {
        super.loadView()
        
        // layout mapView
        mapView = MKMapView()
        self.view = UIView()
        self.view.backgroundColor = UIColor.yellowColor()
        self.view.addSubview( mapView )
        self.view.setTranslatesAutoresizingMaskIntoConstraints( false )


        // initialize Map
        mapView.removeAnnotations(self.mapView.annotations)
        mapView.mapType = MKMapType.Standard
        mapView.delegate = self
        mapView.rotateEnabled = false
        zoomIn()
        
        //show user location
        mapView.showsUserLocation = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        mapView.frame = self.view.bounds
    }
    
    //  adjust Region of mapView
    func zoomIn() {
        println("zoomIn")
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

//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//        
//        var annotationView = MKAnnotationView()
//        annotationView.image = UIImage(named: "myAnnotationImageTest")
//        return annotationView
//        
//    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

