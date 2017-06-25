//
//  MainScreenTableViewCell.swift
//  Loci
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class FriendsLocationTableViewCell: ExpendableTableViewCell {
    
    
    // IBOutlets
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    
    var coordinate:CLLocationCoordinate2D!
    
    var isExpanded:Bool = false
    //TODO: Constraints dem StrassenLabel + userNameLabel hinzufügen
    override func awakeFromNib() {
        super.awakeFromNib()
        // setup label font
        userNameLabel.font = UIFont.ATTableViewSmallFont()
        addressLabel.font = UIFont.ATFont()
        self.imageIconView.image = UIImage(named:"LocationPinBlack.png")
    }
    
    
    
    override func configureWithModelObject(_ model: AnyObject?) {
        let user = model as? User
        if let user = user {
            self.userNameLabel.text = user.name
            //TODO: Location.getStreet + location.getCity funktionieren in diesem Controller nicht, in anderen jedoch schon
            self.addressLabel.text = "Im Werk 11, 8610 Uster"
            
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
        print("hide Map")
    }

    
}
