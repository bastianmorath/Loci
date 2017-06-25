//
//  SharedLocationTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 02/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class SharedLocationTableViewCell: ExpendableTableViewCell {

    // IBOutlets
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
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
    
    override func configureWithModelObject(_ model: AnyObject?) {
        let location = model as? SharedLocation
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
        
        // TODO:- Hier müsste überprüft werden, ob der User die Location schon angesehen hat ( alles erscheint schwarz), oder nicht ( alles erscheint rot)
        self.addressLabel.textColor = UIColor.RedColor()
        self.timeLabel.textColor = UIColor.RedColor()
        self.dateLabel.textColor = UIColor.RedColor()
        self.imageIconView.image = self.imageIconView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.imageIconView.tintColor = UIColor.RedColor()
    }
    
    func hideMap(){
        print("hide Map")
    }
    


    
}
