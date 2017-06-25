//
//  MapView.swift
//  Loci
//
//  Created by Bastian Morath on 21/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
// Subclass of MKMapView

import MapKit

class MapView: MKMapView {
    var coordinate:CLLocationCoordinate2D?
    
    let kZoomConstant = 500 as Double
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // initialize Map
        self.removeAnnotations(self.annotations)
        self.mapType = MKMapType.standard
        self.isRotateEnabled = false
        
        //show user location
        self.showsUserLocation = true
    }
    
    convenience init(frame: CGRect, location: CLLocationCoordinate2D) {
        self.init(frame: frame)
        // Create new Annotation and add it
        self.coordinate = location
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.coordinate!
        annotation.title = "Hier bist du"
        self.addAnnotation(annotation)
        
        self.zoomIn()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView {
    func zoomIn() {
        let userLocation = self.userLocation
            var region: MKCoordinateRegion!
            if let coordinate = self.coordinate{
                region = MKCoordinateRegionMakeWithDistance(coordinate, kZoomConstant, kZoomConstant)
            } else {
                region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, kZoomConstant, kZoomConstant)
            }
            let adjustedRegion = self.regionThatFits(region)
            self.setRegion(adjustedRegion, animated: true)
        
        
    }
    
    
}
