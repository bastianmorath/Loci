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
import MapKit


class MainScreenTableVC: UIViewController, UITableViewDelegate, UIScrollViewDelegate  {
    
    
    //Wird vom MainScreenVC gesetzt; Zeigt, ob der TableView ausgeklappt ist oder nicht
    var tableViewIsExtended = false
    
    var tableView:UITableView!
    
    //DataSource des TableViews
    var sharedLocationsDataSource: MSSharedLocationsDataSource!
    
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt. Wir
    var selectedRowIndexPath: NSIndexPath?
    
    
  
    
    var delegate:TableViewDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = Constants.tableViewFrameNotExtended
        
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
//        var cell = tableView.cellForRowAtIndexPath(indexPath) as FriendsLocationTableViewCell
//        
//        if self.selectedRowIndexPath == indexPath{
//            // Schliesse Die Cell; Lösche selectetRowAtIndexPath
//            cell.selectedRowIndexPath = NSIndexPath()
//            self.selectedRowIndexPath = nil
//            self.tableView.scrollEnabled = true
//            self.tableView.frame = Constants.tableViewFrameExtended
//        } else {
//            //Speichere selectedRowAtIndexPath und location der cell
//            let location = self.sharedLocationsDataSource.modelForIndexPath(indexPath) as Location
//            cell.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
//            self.selectedRowIndexPath = indexPath
//            cell.selectedRowIndexPath = indexPath
//
//            self.tableView.scrollEnabled = false
//            self.tableView.frame = Constants.tableViewFrameNotExtended
//
//        }
//        
//        tableView.beginUpdates()
//        // Cell expanden; TableView nicht mehr scrollable machen; Map in Cell einfügen
//        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        // Geklickte Row nach oben  scrollen
//        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
//        tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, 100, 40))
        headerView.backgroundColor = UIColor.clearColor()
        //Wenn die Cell ausgeklappt ist, d.h. ein indexpath gespeichert ist, dann kein Shared Lcoations anzeigen
        if self.selectedRowIndexPath == nil{
            var sharedLocationsLabel: UILabel = UILabel(frame: CGRectMake(32, 58, 100, 15))
            sharedLocationsLabel.font = UIFont.ATFont()
            sharedLocationsLabel.text = "Shared Locations"
            headerView.addSubview(sharedLocationsLabel)
        }
        
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
        if selectedRowIndexPath == indexPath && selectedRowIndexPath != nil {
            return UIScreen.mainScreen().bounds.height - Constants.topSpace
        }
        return Constants.kCellHeight
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