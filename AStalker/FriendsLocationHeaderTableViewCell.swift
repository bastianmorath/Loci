//
//  MainScreenHeaderTableViewCell.swift
//  AStalker
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class FriendsLocationHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var friendsLabel: UILabel!
    @IBOutlet var updateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // setup label font and size
        friendsLabel.font = UIFont.ATFont()
        updateLabel.font = UIFont.ATFont()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
