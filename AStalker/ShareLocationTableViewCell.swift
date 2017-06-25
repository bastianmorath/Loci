//
//  ShareLocationTableViewCell.swift
//  Loci
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
protocol SelectedUser{
    func selectedUser(_ user: NSMutableSet)->NSMutableSet
}

class ShareLocationTableViewCell: UITableViewCell, SelectedUser {
    var nameLabel = UILabel()
    var checkboxButton: CheckboxButton!
    var likeView = UIImageView()
    /// Der selectedUserArray, der vom TableVC übergebn wird. Er wird gebraucht, um auf die bereits angeklickten User zuzugreifen und je nach dem den Button zu aktivieren oder nicht
    var selectedUserSet: NSMutableSet?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //nameLabel hinzufügen
        self.nameLabel.frame = CGRect(x: 73, y: 8, width: 200, height: 40)
        self.nameLabel.font = UIFont.ATTableViewFont()
        self.contentView.addSubview(self.nameLabel)
        
        // Set checkboxButton
        self.checkboxButton = CheckboxButton(frame: CGRect(x: 27, y: 13, width: 30, height: 30))
        self.addSubview(self.checkboxButton)
        
        //Configure likeView
        self.likeView = UIImageView(image: UIImage(named: "Heart_DarkGrey.png"))
        self.likeView.frame = CGRect(x: 270, y: 13, width: 30, height: 30)
        self.likeView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.likeView)
        
        //Add Constraints to likeView
        let views = ["likeView" : self.likeView]
        let metrics = ["margin":20]
        
        let horizontalConstraintLikeView = "H:[likeView(30)]-margin-|"
        let verticalConstraintLikeView = "V:|-12-[likeView(30)]"


        self.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        self.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //TODO:- Button enablen wenn user selected ist -> Vom Array des ShareLocationVC übernehmen
    override func configureWithModelObject(_ model: AnyObject?) {
        let user = model as? User
        if let user = user {
            self.nameLabel.text = user.name
            if let selectedUser = self.selectedUserSet{
                if selectedUser.contains(user){
                    self.checkboxButton.isChecked = true
                } else {
                    self.checkboxButton.isChecked = false
                }
            }

            //Herzchen rechts hinter den Namen tun, wenn der User ein Freund ist
            if (LocationStore.defaultStore().getLocalUser()!.friends.contains(user)){
                likeView.isHidden = false
            } else {
                likeView.isHidden = true
            }
        }
    }
    
    // SelectedUser-Protocol
    func selectedUser(_ user: NSMutableSet) -> NSMutableSet {
        return user
    }
}
