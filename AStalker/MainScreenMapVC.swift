//
//  MapVC.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/**
*  This Controller controlls the mapContainer View in the MainScreenVC 
*/

import Foundation
import UIKit
import MapKit
import CoreLocation


class MainScreenMapVC: UIViewController {
    
    var mapView:MKMapView = MKMapView()
    
    override func loadView() {
        super.loadView()
        
        // Setup mapView
        mapView.frame = self.view.frame
        mapView.mapType = MKMapType.Hybrid
        self.view = mapView
        self.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.view.setTranslatesAutoresizingMaskIntoConstraints( true )
        
        //initialize Location
        var location = CLLocationCoordinate2D(
            latitude: 48.783667,
            longitude: 9.181459 )
        
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var region = MKCoordinateRegion(center:location,span:span)
        
        mapView.region = region
        var annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Stuttgart 21"
        annotation.subtitle = "Ewige Baustelle"
        
        mapView.addAnnotation(annotation)
        
    

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

