//
//  MainScreenTableViewCell.swift
//  AStalker
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class FriendsLocationTableViewCell: UITableViewCell {
    
    
    // IBOutlets
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
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
        
        //Hier müsste überprüft werden, ob der User die Location schon angesehen hat ( alles erscheint schwarz), oder nicht ( alles erscheint rot)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
