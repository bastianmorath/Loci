//
//  ShareLocationTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class ShareLocationTableViewCell: UITableViewCell, UITableViewDelegate {
    var nameLabel = UILabel()
    var redView = UIView()
    
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
        self.contentView.addSubview(nameLabel)
        self.nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
//      var viewsDictionary = ["nameLabel":self.nameLabel]
//        
//      var constraintTop = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[nameLabel]", options: nil, metrics: nil, views: viewsDictionary)
//      nameLabel.addConstraints(constraintTop)
        
        //CircleView hinzufügen
        var circleView = CircleView(frame: CGRectMake(26, 8, 35, 35))
        self.contentView.addSubview(circleView)
        
        //RedCheckmark hinzufügen und hiden(default)
        redView = self.redCheckmarkView()
        
        circleView.addSubview( redView )
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
                var imageView = UIImageView(image: UIImage(named: "Heart_DarkGrey.png"))
                imageView.frame = CGRectMake(270, 13, 30, 30)
                self.contentView.addSubview(imageView)

//                var viewsDictionary = ["imageView":imageView]
//                var constraintRight = NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView]-30-|", options: nil, metrics: nil, views: viewsDictionary)
//                imageView.addConstraints(constraintRight)

            }
            
        }
    }
    //Roter Checkmark-View
    func redCheckmarkView() -> UIView {

        var circleView = CheckmarkView(frame: CGRectMake(5, 5, 25, 25))
   
        return circleView
    }

}
