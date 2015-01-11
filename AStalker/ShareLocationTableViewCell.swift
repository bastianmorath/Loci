//
//  ShareLocationTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class ShareLocationTableViewCell: UITableViewCell {
    var nameLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.ATTitleFont()
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabel.frame = CGRectMake(30, 30, 200, 50)
        
        self.addSubview(nameLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func configureWithModelObject(model: AnyObject?) {
        let user = model as? User
        if let user = user {
            
            self.nameLabel.text = user.name
            
            //Herzchen rechts hinter den namen tun, wenn der User ein Freund ist
            if LocationStore.defaultStore().getLocalUser().friends.containsObject(user){
                println("Herzchen")
            }
        }
    }
    
    
}
