//
//  UIDevice+ATDevice.swift
//  AStalker
//
//  Created by Bastian Morath on 19/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
// This Extension Class helps to differentiate between the iPad and iPhone models
import UIKit
import Foundation
extension UIDevice {
    
    var IS_OS_8_OR_LATER:Bool {
        get{
            return NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0))
        }
    }
   
    func isIPad() -> Bool{
        if self.userInterfaceIdiom == .Pad {
            return true
        }
        return false
    }
    
    func isIPhone() -> Bool{
        if self.userInterfaceIdiom == .Phone {
            return true
        }
        return false
    }
    
    func isIPhone5() -> Bool{
        if UIScreen.mainScreen().bounds.size.height == 568{
            return true
        }
        return false
    }

    
    func isIPhone6() -> Bool{
        if UIScreen.mainScreen().bounds.size.height == 667 || (UIScreen.mainScreen().bounds.size.height == 568 && UIScreen.mainScreen().nativeScale < UIScreen.mainScreen().scale && IS_OS_8_OR_LATER){
            return true
        }
        return false
    }
    
    func isIPhone6Plus() -> Bool{
        if UIScreen.mainScreen().bounds.size.height == 736 || (UIScreen.mainScreen().bounds.size.height == 667 && UIScreen.mainScreen().nativeScale < UIScreen.mainScreen().scale && IS_OS_8_OR_LATER){
            return true
        }
        return false
    }
}
