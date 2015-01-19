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

    @IBOutlet weak var descriptionLabel: UILabel!
    
    var addFriendsButton: UIButton?
    
    //DataSource des TableViews
    var addFriendsDataSource: AddFriendsDataSource!

    var localUser:LocalUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addFriendsButton = UIButton.ATButton(UIButton.ATButtonType.Contact, color: UIButton.ATColor.White)
        if let button = addFriendsButton{
            button.addTarget(self, action: "addFriendsPressed", forControlEvents:UIControlEvents.TouchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.TopRight)
        }
        
        self.descriptionLabel.numberOfLines = 0
        
        // Define the tableView's dataSource
        
        localUser = (LocationStore.defaultStore().getLocalUser())
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
        self.tableView.tableHeaderView = headerView;

        return headerView
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedUser = self.addFriendsDataSource.modelForIndexPath(indexPath) as User
        var cell = tableView.cellForRowAtIndexPath(indexPath) as AddFriendsTableViewCell
        
        if localUser.friends.containsObject(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus locations.sharedUsers
            var mutableSet = NSMutableSet(set: localUser.friends)
            mutableSet.removeObject(selectedUser)
           localUser.friends = NSSet(set: mutableSet)
        } else {
            //Füge den User bei lcoation.sharedUsers hinzu und Selecte ihn im View(roter Checkmark-View)
            localUser.friends = localUser.friends.setByAddingObject(selectedUser)
        }
        cell.heartButton.isChecked = !cell.heartButton.isChecked
    }

    func addFriendsPressed(){
        self.navigationController?.popViewControllerAnimated(true)

    }

}
