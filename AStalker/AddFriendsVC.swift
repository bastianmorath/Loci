//
//  AddFriendsVC.swift
//  Loci
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import CoreData

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
        addFriendsDataSource = AddFriendsDataSource(tableView: tableView, user: localUser!)
        tableView.dataSource = addFriendsDataSource
        
        self.tableView.frame = CGRectMake(0, Constants.topSpace, Constants.screenWidth, Constants.screenHeight-2 * Constants.topSpace)

    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 20))
        headerView.backgroundColor = UIColor.clearColor()
        var label: UILabel = UILabel(frame: CGRectMake(34, 24, 40, 20))
        label.font = UIFont.ATFont()
        
        //Friends-Section
        if section == 0{
            label.text = "Friends"
        } else {
            label.text = "Contacts"
        }
        
        headerView.addSubview(label)
        //self.tableView.tableheader = headerView;
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedUser = self.addFriendsDataSource.modelForIndexPath(indexPath) as User
        var cell = tableView.cellForRowAtIndexPath(indexPath) as AddFriendsTableViewCell
        
        if localUser.friends.containsObject(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus locations.friends
            LocationStore.defaultStore().deleteUserInFriendsOfLocalUser(selectedUser)
        } else {
            //Füge den User bei lcoation.friends hinzu und Selecte ihn im View(roter Checkmark-View)
            LocationStore.defaultStore().addUserToFriendsOfLocalUser(selectedUser)
        }
        cell.heartButton.isChecked = !cell.heartButton.isChecked
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Constants.kCellHeightAddFriends
    }
    
    func addFriendsPressed(){
        self.dismissViewController()
    }
    

    
}
