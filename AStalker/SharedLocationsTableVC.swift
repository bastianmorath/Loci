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


class SharedLocationsTableVC: LIViewController, UITableViewDelegate, UIScrollViewDelegate  {
    
    //Wird vom MainScreenVC gesetzt; Zeigt, ob der TableView ausgeklappt ist oder nicht
    var tableViewIsExtended = false
    
    //DataSource des TableViews
    var sharedLocationsDataSource: MSSharedLocationsDataSource!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let metrics = ["margin":18]
        let horizontalConstraintLikeView = "H:[timeLabel]-margin-|"
        let verticalConstraintLikeView = "V:|-60-[timeLabel]"
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    
    func reloadData(){
        sharedLocationsDataSource = MSSharedLocationsDataSource(tableView: self.tableView)
        self.tableView.dataSource = sharedLocationsDataSource
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        var cell =  SharedLocationTableViewCell.cellForTableView( tableView, atIndexPath: indexPath, withModelSource: self.sharedLocationsDataSource ) as! SharedLocationTableViewCell
        if let selectedRowIndexPath = self.selectedRowIndexPath{
            // Cell schliessen
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 0, height: 0), animated: true)
            self.sharedLocationsDataSource.selectedRowIndexPath = nil
            self.selectedRowIndexPath = nil
            //self.tableView.scrollEnabled = true

        } else {
            // Cell expanden
            let location = self.sharedLocationsDataSource.modelForIndexPath(indexPath) as! Location
            let coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude), longitude: Double(location.longitude))
            self.selectedRowIndexPath = indexPath
            self.sharedLocationsDataSource.selectedRowIndexPath = self.selectedRowIndexPath
            self.sharedLocationsDataSource.coordinateOfMap = coordinate
            self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
            //self.tableView.scrollEnabled = false
        }
    
        tableView.beginUpdates()
        // Cell expanden; TableView nicht mehr scrollable machen; Map in Cell einfügen
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        // Geklickte Row nach oben  scrollen
        tableView.endUpdates()
    }
}
