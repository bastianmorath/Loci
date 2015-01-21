//
//  Constants.swift
//  AStalker
//
//  Created by Bastian Morath on 21/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

struct Constants {
    //Höhe der Cells in den TableViews
    static let kCellHeight = 52 as CGFloat
    
    // Höhe des Screens
    static  var screenHeight:CGFloat {
        get{
            return UIScreen.mainScreen().bounds.height
        }
    }
    
    //Minimale Höhe der Map, wenn der tableView ausgeklappt ist(Abhängig von der Screen-Grösse)
    static var topSpace:CGFloat {
        get{
            if UIDevice.currentDevice().isIPhone5(){
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
}
