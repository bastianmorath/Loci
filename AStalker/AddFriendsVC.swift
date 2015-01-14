//
//  AddFriendsVC.swift
//  AStalker
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class AddFriendsVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    var addFriendsButton: UIButton?
    
    //DataSource des TableViews
    var addFriendsDataSource: AddFriendsDataSource!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addFriendsButton = UIButton.ATButton(UIButton.ATButtonType.Contact, color: UIButton.ATColor.White)
        if let button = addFriendsButton{
            button.addTarget(self, action: "sharePressed", forControlEvents:UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.TopRight)
        }
        
        // Define the tableView's dataSource
        let localUser = (LocationStore.defaultStore().getLocalUser())
        addFriendsDataSource = AddFriendsDataSource(tableView: tableView, user: localUser!, location: nil)
        tableView.dataSource = addFriendsDataSource

    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var label: UILabel = UILabel(frame: CGRectMake(28, -4, 40, 50))
        label.font = UIFont.ATFont()
        headerView.addSubview(label)
        
        //Friends-Section
        if section == 0{
            label.text = "Friends"
        } else {
            // Contacts-Section
            label.text = "Contacts"
        }
        return headerView
    }
    
    


}
