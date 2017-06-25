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
    
    var addFriendsButton: LociButton?
    
    //DataSource des TableViews
    var addFriendsDataSource: AddFriendsDataSource!
    
    var localUser:LocalUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addFriendsButton = LociButton(type:.contact, color: .white)
        if let button = addFriendsButton{
            button.addTarget(self, action: #selector(AddFriendsVC.addFriendsPressed), for:UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.topRight)
        }
        
        self.descriptionLabel.numberOfLines = 0
        
        // Define the tableView's dataSource
        
        localUser = (LocationStore.defaultStore().getLocalUser())
        addFriendsDataSource = AddFriendsDataSource(tableView: tableView, user: localUser!)
        tableView.dataSource = addFriendsDataSource
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        headerView.backgroundColor = UIColor.clear
        let label: UILabel = UILabel(frame: CGRect(x: 34, y: 24, width: 40, height: 20))
        label.font = UIFont.ATFont()
        
        //Friends-Section
        if section == 0{
            label.text = "Friends"
        } else {
            label.text = "Contacts"
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser = self.addFriendsDataSource.modelForIndexPath(indexPath) as! User
        var cell = tableView.cellForRow(at: indexPath) as! AddFriendsTableViewCell
        
        if localUser.friends.contains(selectedUser){
            //User ist schon ausgewählt. Deselecte ihn im View und lösche ihn aus locations.friends
            LocationStore.defaultStore().deleteUserInFriendsOfLocalUser(selectedUser)
        } else {
            //Füge den User bei lcoation.friends hinzu und Selecte ihn im View(roter Checkmark-View)
            LocationStore.defaultStore().addUserToFriendsOfLocalUser(selectedUser)
        }
        cell.heartButton.isChecked = !cell.heartButton.isChecked
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kCellHeightAddFriends
    }
    
    func addFriendsPressed(){
        self.dismissViewController()
    }
    

    
}
