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
    var checkboxButton: CheckboxButton!
    var likeView = UIImageView()
    //Die Location, die vom TableVC übergebn wird. Sie wird gebraucht, um auf die bereits angeklickten User zuzugreifen und je nach dem den Button zu aktivieren oder nicht
    var location: Location?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //nameLabel hinzufügen
        self.nameLabel.frame = CGRectMake(73, 8, 200, 40)
        self.nameLabel.font = UIFont.ATTableViewFont()
        self.contentView.addSubview(self.nameLabel)
        
        // Set checkboxButton
        self.checkboxButton = CheckboxButton(frame: CGRectMake(27, 13, 30, 30))
        self.addSubview(self.checkboxButton)
        
        //Configure likeView
        self.likeView = UIImageView(image: UIImage(named: "Heart_DarkGrey.png"))
        self.likeView.frame = CGRectMake(270, 13, 30, 30)
        self.likeView.setTranslatesAutoresizingMaskIntoConstraints(false)

        self.contentView.addSubview(self.likeView)
        
        //Add Constraints to likeView
        let views = ["likeView" : self.likeView]
        let metrics = ["margin":20]
        
        var horizontalConstraintLikeView = "H:[likeView(30)]-margin-|"
        var verticalConstraintLikeView = "V:|-12-[likeView(30)]"


        self.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintLikeView, options: nil, metrics: metrics, views: views ) )
        self.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintLikeView, options: nil, metrics: metrics, views: views ) )

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func configureWithModelObject(model: AnyObject?) {
        let user = model as? User
        if let user = user {
            self.nameLabel.text = user.name
            if let location = self.location{
                if location.sharedUsers.containsObject(user){
                    self.checkboxButton.isChecked = true
                } else {
                    self.checkboxButton.isChecked = false
                }

            }
            
            //Herzchen rechts hinter den namen tun, wenn der User ein Freund ist
            if (LocationStore.defaultStore().getLocalUser()!.friends.containsObject(user)){
                likeView.hidden = false
            } else {
                likeView.hidden = true
            }
        }
    }
}
