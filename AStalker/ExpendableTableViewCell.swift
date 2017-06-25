//
//  ExpendableTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 09/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class ExpendableTableViewCell: UITableViewCell {
    var mapView:MKMapView?
    var hideMapButton:UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func expandCellWithCoordinate(_ coordinate: CLLocationCoordinate2D){
        self.mapView = MapView(frame: CGRect(x: 0, y: Constants.kCellHeight, width: self.frame.width, height: Constants.screenHeight - Constants.topSpace - Constants.kCellHeight-30), location: coordinate)
        mapView?.isUserInteractionEnabled = false
        self.hideMapButton = LociButton(type: .closeArrow, color: .white)
        self.hideMapButton?.translatesAutoresizingMaskIntoConstraints = false
        self.hideMapButton!.addTarget(self, action: "hideMap", for: .touchUpInside)
        self.contentView.addSubview(hideMapButton!)
        self.contentView.addSubview(self.mapView!)
        
        
        let views = ["button" : self.hideMapButton!]
        /// margin: Abstand der Buttons zum Rand
        let metrics = ["margin": kMargin]
        
        var verticalConstraint =   "V:[button]-10-|"
        var heightConstraint = "V:[button(\(35))]"
        var widthConstraint = "H:[button(\(35))]"
        
        if let superview =  self.hideMapButton!.superview{
            self.hideMapButton!.superview?.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraint, options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: metrics, views: views ) )
            self.hideMapButton!.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: heightConstraint, options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
            self.hideMapButton!.superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: widthConstraint, options: NSLayoutFormatOptions.alignAllLastBaseline, metrics: nil, views: views))
            //superview.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraint, options: nil, metrics: metrics, views: views ) )
            self.hideMapButton!.superview?.addConstraint(NSLayoutConstraint(item: self.hideMapButton!, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1, constant: 0))
        }
    }
    
    func closeCell(){
        self.mapView?.removeFromSuperview()
        self.hideMapButton?.removeFromSuperview()
        mapView = nil
        hideMapButton = nil
    }
}
