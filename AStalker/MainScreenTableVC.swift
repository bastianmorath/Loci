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



class MainScreenTableVC: UIViewController, UITableViewDelegate, UIScrollViewDelegate  {
    
    
    
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
    
    var delegate:TableViewDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.tableViewHeight)
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.bounces = false
        self.view.addSubview(tableView)
        
        sharedLocationsDataSource = MSSharedLocationsDataSource(tableView: self.tableView)
        self.tableView.dataSource = sharedLocationsDataSource
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 100, 40))
        headerView.backgroundColor = UIColor.clearColor()
        var sharedLocationsLabel: UILabel = UILabel(frame: CGRectMake(32, 58, 100, 15))
        sharedLocationsLabel.font = UIFont.ATFont()
        sharedLocationsLabel.text = "Shared Locations"
        headerView.addSubview(sharedLocationsLabel)
        
        var timeLabel: UILabel = UILabel(frame: CGRectMake(270, 58, 40, 15))
        timeLabel.font = UIFont.ATFont()
        timeLabel.text = "Time"
        headerView.addSubview(timeLabel)
        timeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //Add Constraints to timeLabel
        let views = ["timeLabel" : timeLabel]
        let metrics = ["margin":22]
        var horizontalConstraintLikeView = "H:[timeLabel]-margin-|"
        var verticalConstraintLikeView = "V:|-60-[timeLabel]"
        headerView.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraintLikeView, options: nil, metrics: metrics, views: views ) )
        headerView.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraintLikeView, options: nil, metrics: metrics, views: views ) )

        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 52
    }
    
    //MARK:- Scroll View Delegate
    
    // Detecte, wenn der User zuoberst angekommen ist und weiter nach oben scrollt
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        var translation = scrollView.panGestureRecognizer.translationInView(scrollView.superview!);
        if  translation.y > 0 && scrollView.contentOffset.y == 0 {
            delegate.animateViewToBottom()
        }
    }
}