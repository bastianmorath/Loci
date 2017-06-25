//
//  Constants.swift
//  Loci
//
//  Created by Bastian Morath on 21/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

struct Constants {
    
    ///Verhältnis vom mapContainer zum TableView
     static var kAspectRatioMapToTableView: CGFloat{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return 1.01
        } else {
            return 1.24
        }
    }
    
    /// Default-Höhe der Cells in den TableViews
    static let kCellHeight = 50 as CGFloat
    
    //Höhe der Cells im AddFriendsTableVC
    static let kCellHeightAddFriends = 57 as CGFloat
    
    //Höhe des Headers im TableView von ShareLocationVC und FavoriteLocationsVC (headerHeight !>30)
    static let headerHeight = 60 as CGFloat

    /// Höhe des Screens
    static  var screenHeight:CGFloat {
        get{
            return UIScreen.main.bounds.height
        }
    }
    
    /// Breite des Screens
    static  var screenWidth:CGFloat {
        get{
            return UIScreen.main.bounds.width
        }
    }
    
    
    ///Minimale Höhe der Map, wenn der tableView ausgeklappt ist(Abhängig von der Screen-Grösse)
    static var topSpace:CGFloat {
        get{
            if UIDevice.current.isIPhone5(){
                return 82
            }
            if UIDevice.current.isIPhone6(){
                return 150
            }
            if UIDevice.current.isIPhone6Plus(){
                return 150
            }
            if UIDevice.current.isIPad(){
                return 238
            }
            
            return 82
        }
    }
    
    ///Minimale Höhe der Map, wenn der tableView ausgeklappt ist
    static var mapHeight:CGFloat {
        return 92
    }
    
    static var tableViewFrameExtended:CGRect{
        get{
            return CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.screenHeight - Constants.topSpace)
        }
    }
    
    static var tableViewFrameNotExtended:CGRect{
        get{
            return CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableViewHeight)
        }
    }
    
    ///Height of TableViewNotExtended
    static var tableViewHeight:CGFloat {
        get{
                return Constants.screenHeight - Constants.screenWidth*Constants.kAspectRatioMapToTableView
        }
    }
}
