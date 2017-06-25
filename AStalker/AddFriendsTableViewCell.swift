//
//  AddFriendsTableViewCell.swift
//  Loci
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class AddFriendsTableViewCell: UITableViewCell {
    var nameLabel = UILabel()
    var heartButton: HeartButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.ATTitleFont()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //nameLabel hinzufügen
        self.nameLabel.frame = CGRect(x: 76, y: 10, width: 200, height: 40)
        self.nameLabel.font = UIFont.ATTableViewFont()
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.nameLabel)
        
        // Set checkboxButton
        self.heartButton = HeartButton(frame: CGRect(x: 30, y: 15, width: 30, height: 30))
        self.addSubview(self.heartButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func configureWithModelObject(_ model: AnyObject?) {
        let user = model as? User
        let localUser = LocationStore.defaultStore().getLocalUser()
        if let user = user{
            self.nameLabel.text = user.name
            
            if localUser!.friends.contains(user){
                self.heartButton.isChecked = true
            } else {
                self.heartButton.isChecked = false
            }
        }
    }
}
