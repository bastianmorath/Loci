//
//  MainScreenTableViewCell.swift
//  Loci
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class FriendsLocationTableViewCell: UITableViewCell {
    
    
    // IBOutlets
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var mapView:MKMapView?
    
    var hideMapButton:UIButton?
    
    var coordinate:CLLocationCoordinate2D!
    
    var isExpanded:Bool = false
    //TODO: Constraints dem StrassenLabel + userNameLabel hinzufügen
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // setup label font
        userNameLabel.font = UIFont.ATTableViewSmallFont()
        addressLabel.font = UIFont.ATFont()
        dateLabel.font = UIFont.ATFont()
        timeLabel.font = UIFont.ATTableViewSmallFont()
        
        
        self.imageIconView.image = UIImage(named:"LocationPinBlack.png")
    }
    
    
    
    override func configureWithModelObject(model: AnyObject?) {
        let location = model as? Location
        if let location = location {
            self.userNameLabel.text = location.creator.name
            //TODO: Location.getStreet + location.getCity funktionieren in diesem Controller nicht, in anderen jedoch schon
            self.addressLabel.text = location.getStreet() + ", " + location.getCity()
            self.dateLabel.text = location.getDateFormatted()
            self.timeLabel.text = location.getTimeFormatted()
        }
        
        if !self.isExpanded{
            self.mapView?.removeFromSuperview()
            self.hideMapButton?.removeFromSuperview()
            mapView = nil
            hideMapButton = nil

        }
        
        //Hier müsste überprüft werden, ob der User die Location schon angesehen hat ( alles erscheint schwarz), oder nicht ( alles erscheint rot)
        
    }
    
    func hideMap(){
        println("hide Map")
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func expandCellWithCoordinate(coordinate: CLLocationCoordinate2D){
        self.mapView = MapView(frame: CGRectMake(0, Constants.kCellHeight, self.frame.width, Constants.screenHeight - Constants.topSpace - Constants.kCellHeight-30), location: coordinate)
        mapView?.userInteractionEnabled = false
        self.hideMapButton = UIButton.ATButton(.CloseArrow, color: .White)
        self.hideMapButton!.center = CGPointMake(self.frame.width/2 - 15, self.frame.height - 40)
        
        self.hideMapButton!.addTarget(self, action: "hideMap", forControlEvents: .TouchUpInside)
        self.contentView.addSubview(hideMapButton!)
        self.contentView.addSubview(self.mapView!)
    }
    
    func closeCell(){
        self.mapView?.removeFromSuperview()
        self.hideMapButton?.removeFromSuperview()
        mapView = nil
        hideMapButton = nil
    }
    
}
