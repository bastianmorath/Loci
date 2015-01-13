//
//  AddFriendsTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class AddFriendsTableViewCell: UITableViewCell {
    var nameLabel = UILabel()
    var checkboxButton: CheckboxButton!
    var likeView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.ATTitleFont()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //nameLabel hinzufügen
        self.nameLabel.frame = CGRectMake(76, 10, 200, 40)
        self.nameLabel.font = UIFont.ATTableViewFont()
        self.nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(self.nameLabel)
        
        // Set checkboxButton
        self.checkboxButton = CheckboxButton(frame: CGRectMake(30, 15, 30, 30))
        self.addSubview(self.checkboxButton)
        
        //Configure likeView
        likeView = UIImageView(image: UIImage(named: "Heart_DarkGrey.png"))
        likeView.frame = CGRectMake(270, 13, 30, 30)
        self.contentView.addSubview(likeView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func configureWithModelObject(model: AnyObject?) {
        let user = model as? User
        if let user = user {
            self.nameLabel.text = user.name
            
            //Herzchen rechts hinter den namen tun, wenn der User ein Freund ist
            if LocationStore.defaultStore().getLocalUser()?.friends.containsObject(user) != nil{
                likeView.hidden = false
            }
        }
    }

}
