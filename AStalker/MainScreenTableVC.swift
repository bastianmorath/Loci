//
//  TableVC.swift
//  Loci
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
    
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt.
    var selectedRowIndexPath: IndexPath?
    
    
  
    
    var delegate:TableViewAndMapDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = Constants.tableViewFrameNotExtended
        
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell = tableView.cellForRow(at: indexPath) as! FriendsLocationTableViewCell
        
        if indexPath == self.selectedRowIndexPath{
            // Cell schliessen
            self.tableView.isScrollEnabled = true
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 0, height: 0), animated: true)
            self.sharedLocationsDataSource.selectedRowIndexPath = IndexPath()
            self.selectedRowIndexPath = IndexPath()
            
        } else {
            // Cell expanden
            let location = self.sharedLocationsDataSource.modelForIndexPath(indexPath) as! Location
            let coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
            self.selectedRowIndexPath = indexPath
            self.sharedLocationsDataSource.selectedRowIndexPath = self.selectedRowIndexPath!
            self.sharedLocationsDataSource.coordinateOfMap = coordinate
            self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
            self.tableView.isScrollEnabled = false
        }
        
        tableView.beginUpdates()
        // Cell expanden; TableView nicht mehr scrollable machen; Map in Cell einfügen
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        // Geklickte Row nach oben  scrollen
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        headerView.backgroundColor = UIColor.clear
        //Wenn die Cell ausgeklappt ist, d.h. ein indexpath gespeichert ist, dann kein Shared Lcoations anzeigen
        if self.selectedRowIndexPath == nil{
            let sharedLocationsLabel: UILabel = UILabel(frame: CGRect(x: 32, y: 58, width: 100, height: 15))
            sharedLocationsLabel.font = UIFont.ATFont()
            sharedLocationsLabel.text = "Shared Locations"
            headerView.addSubview(sharedLocationsLabel)
        }
        
        let timeLabel: UILabel = UILabel(frame: CGRect(x: 270, y: 58, width: 40, height: 15))
        timeLabel.font = UIFont.ATFont()
        timeLabel.text = "Time"
        headerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        //Add Constraints to timeLabel
        let views = ["timeLabel" : timeLabel]
        let metrics = ["margin":22]
        let horizontalConstraintLikeView = "H:[timeLabel]-margin-|"
        let verticalConstraintLikeView = "V:|-60-[timeLabel]"
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )

        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //indexPath is NSMutableIndexPath, so create an indexPath
        let index = IndexPath(row: indexPath.row, section: indexPath.section)
        
        if self.selectedRowIndexPath == index{
            return Constants.screenHeight - Constants.topSpace
        }
        return Constants.kCellHeight
    }
    
    //MARK:- Scroll View Delegate
    
    // Detecte, wenn der User zuoberst angekommen ist und weiter nach oben scrollt
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!);
        if  translation.y > 0 && scrollView.contentOffset.y == 0 {
            // Geklickte Row nach oben  scrollen
            delegate.animateViewToBottom()
        }
    }
    
}
