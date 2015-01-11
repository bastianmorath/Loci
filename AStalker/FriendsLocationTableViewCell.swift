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
        
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //  Configure the view for the selected state
    }
    
}
