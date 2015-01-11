//
//  MainScreenTableViewCell.swift
//  AStalker
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    
    // IBOutlets
    @IBOutlet weak var imageIconView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
