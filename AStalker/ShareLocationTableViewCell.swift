//
//  ShareLocationTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class ShareLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isTickedButton: UIButton!
    @IBAction func tickPressed(sender: AnyObject) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameLabel.font = UIFont.ATTitleFont()
        
        //
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        
        
    }
    
    override func configureWithModelObject(model: AnyObject?) {
        
        if let user: User = model as? User{
            self.nameLabel.text = user.name
            //Herzchen rechts hinter den namen tun, wenn der User ein Freund ist
//            if LocationStore.defaultStore().getLocalUser().friends.containsObject(user){
//                println("Herzchen")
//            }
        }
    }
}
