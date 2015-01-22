//
//  Constants.swift
//  AStalker
//
//  Created by Bastian Morath on 21/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

struct Constants {
    
    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    static let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    static let kAspectRatioMapToTableViewIPad: CGFloat = 1.04
    
    //Höhe der Cells in den TableViews
    static let kCellHeight = 52 as CGFloat
    
    // Höhe des Screens
    static  var screenHeight:CGFloat {
        get{
            println(UIScreen.mainScreen().bounds.height)
            return UIScreen.mainScreen().bounds.height
        }
    }
    
    // breite des Screens
    static  var screenWidth:CGFloat {
        get{
            println(UIScreen.mainScreen().bounds.width)
            return UIScreen.mainScreen().bounds.width
        }
    }
    
    //Minimale Höhe der Map, wenn der tableView ausgeklappt ist(Abhängig von der Screen-Grösse)
    static var topSpace:CGFloat {
        get{
            if UIDevice.currentDevice().isIPhone5(){
                println(82)
                return 82
            }
            if UIDevice.currentDevice().isIPhone6(){
                return 150
            }
            if UIDevice.currentDevice().isIPhone6Plus(){
                return 150
            }
            if UIDevice.currentDevice().isIPad(){
                return 250
            }
            
            return 82
        }
    }
    
    static var tableViewFrameExtended:CGRect{
        get{
            println(CGRectMake(0, 0, Constants.screenWidth, Constants.screenHeight - Constants.topSpace))
            return CGRectMake(0, 0, Constants.screenWidth, Constants.screenHeight - Constants.topSpace)
        }
    }
    
    static var tableViewFrameNotExtended:CGRect{
        get{
            println(CGRectMake(0, 0, Constants.screenWidth, Constants.tableViewHeight))
            return CGRectMake(0, 0, Constants.screenWidth, Constants.tableViewHeight)
        }
    }
    
    // Height of TableViewNotExtended
    static var tableViewHeight:CGFloat {
        get{
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
                println(Constants.screenHeight - Constants.screenWidth*Constants.kAspectRatioMapToTableViewIPad)
                return Constants.screenHeight - Constants.screenWidth*Constants.kAspectRatioMapToTableViewIPad
            } else {
                println(Constants.screenHeight - Constants.screenWidth*Constants.kAspectRatioMapToTableViewIPhone)
                return Constants.screenHeight - Constants.screenWidth*Constants.kAspectRatioMapToTableViewIPhone
            }
        }
    }
}
