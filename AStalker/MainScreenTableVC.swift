//
//  TableVC.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/**
*  This Controller controlls the tableContainer View in the MainScreenVC and the SwipeGesture
*  The TableView shows the locations of the users friends
*/

import Foundation
import UIKit

class MainScreenTableVC: UIViewController, UITableViewDelegate  {
    
    //Wird vom MainScreenVC gesetzt; Zeigt, ob der TableView ausgeklappt ist oder nicht
    var tableViewIsExtended = false
    
    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    let kAspectRatioMapToTableViewIPad: CGFloat = 1.04
    
    var tableView:UITableView!
    
    //DataSource des TableViews
    var sharedLocationsDataSource: MSSharedLocationsDataSource!
    
    // Height of TableView
    var tableViewHeight:CGFloat {
        get{
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
                return self.view.frame.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPad
            } else {
                return self.view.frame.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.tableViewHeight)
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView)
        
        sharedLocationsDataSource = MSSharedLocationsDataSource(tableView: self.tableView)
        self.tableView.dataSource = sharedLocationsDataSource
        
        //Swipe Gesture-Recognizer hinzufügen
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tableViewExtendedNotification", name:"TableViewExtendedNotificationFromMapVC", object: nil)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected Row")
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 50, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var sharedLocationsLabel: UILabel = UILabel(frame: CGRectMake(32, 25, 100, 50))
        sharedLocationsLabel.font = UIFont.ATFont()
        sharedLocationsLabel.text = "Shared Locations"
        headerView.addSubview(sharedLocationsLabel)
        
        //TODO: Diesem label Constraints hinzufügen
        var timeLabel: UILabel = UILabel(frame: CGRectMake(270, 25, 40, 50))
        timeLabel.font = UIFont.ATFont()
        timeLabel.text = "Time"
        
        headerView.addSubview(timeLabel)
        
        
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // Swipe Gesture Recognizer
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Up:
                println("Swiped up")
                if !tableViewIsExtended{
                    // tableView heraufanimieren
                    NSNotificationCenter.defaultCenter().postNotificationName("TableViewExtendedNotificationFromTableViewVC", object: nil)
                    self.animateTableViewUp()
                }
            case UISwipeGestureRecognizerDirection.Down:
                println("Swiped down")
                NSNotificationCenter.defaultCenter().postNotificationName("TableViewExtendedNotificationFromTableViewVC", object: nil)
                self.animateTableViewDown()
            default:
                break
            }
        }
    }
    
    // Notification; .tableViewIsExtendet inversen
    func tableViewExtendedNotification(){
        self.tableViewIsExtended = !self.tableViewIsExtended
    }
    
    
    //TODO: ShareButton vom mainScreenVC hier in den TableView verschieben, unter anderem, um auf ihn zugreifen zu können
    func animateTableViewUp(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * 55 - self.tableViewHeight
            
            let topSpace = 100 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            //self.shareYourLocationButton.backgroundColor = UIColor.RedColor()
            self.view.frame = CGRectMake(0, -transitionConstant, self.view.frame.width, self.view.frame.height+2*transitionConstant)
        })
    }
    
    func animateTableViewDown(){
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * 55 - self.tableViewHeight
            
            let topSpace = 100 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            //self.shareYourLocationButton.backgroundColor = UIColor.GreyColor()
            self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)        })
    }
}