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
            }
        }
    }
    //Roter Checkmark-View
    func redCheckmarkView() -> UIView {

        var circleView = CheckmarkView(frame: CGRectMake(25, 8, 30, 30))
   
        return circleView
    }

}
