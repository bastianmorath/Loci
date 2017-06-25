//
//  MapVC.swift
//  Loci
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


class MainScreenMapVC: UIViewController, MKMapViewDelegate{
    
    var mapView:MapView!
    
    var delegate:TableViewAndMapDelegate!
    
    var mapIsAtBottom = false
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // layout mapView
        let mapHeight = Constants.screenWidth * Constants.kAspectRatioMapToTableView
        mapView = MapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: mapHeight))
        mapView.delegate = self
        self.view.addSubview(mapView )
        
        mapView.zoomIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Change frame of legal-label
        let legalLabel = self.mapView.subviews[1] as! UILabel
        //legalLabel.center = CGPointMake(280, 200)
        legalLabel.translatesAutoresizingMaskIntoConstraints = false
        let views = ["label" : legalLabel]
        let metrics = ["margin": kMargin, "bottomMargin":50]
        
        let horizontalConstraint = "H:[label]-margin-|"
        let verticalConstraint = "V:[label]-margin-|"
        self.mapView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        self.mapView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        
        
    }
    
    //   Keep track of user: if user changes position center of mapView will change
    func mapView(_ mapView: MKMapView!, didUpdate userLocation: MKUserLocation!) {
       
        mapView.centerCoordinate = userLocation.location!.coordinate
        // stop AnnotationView callout
        if let annotationView = mapView.view(for: userLocation) {
            //annotationView.canShowCallout = false
        }
    }
    
    // Gehe zum ShareLocationVC
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var longitude = 47.35 as Double
        var latitude = 8.68333 as Double
        if let location = self.mapView.userLocation.location{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        } else {
            print("Couldn't set UserLocation. Random UserLocation set")
        }
        var locationToShare = LocationStore.defaultStore().createSharedLocation( nil, longitude: longitude, latitude: latitude, user: nil)
        
        self.delegate.didSelectAnnotationPin(locationToShare!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//        func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        if self.mapIsAtBottom{
//            for controller in self.parentViewController!.childViewControllers{
//                if controller.isKindOfClass(AddFriendsVC) || controller.isKindOfClass(ShareLocationVC) || controller.isKindOfClass(FavoritePlacesVC){
//                    (controller as! UIViewController).dismissViewController()
//                }
//            }
//        }

  //  }
    
}

