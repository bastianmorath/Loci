//
//  UIDevice+ATDevice.swift
//  Loci
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
            return ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0))
        }
    }
   
    func isIPad() -> Bool{
        if self.userInterfaceIdiom == .pad {
            return true
        }
        return false
    }
    
    func isIPhone() -> Bool{
        if self.userInterfaceIdiom == .phone {
            return true
        }
        return false
    }
    
    func isIPhone5() -> Bool{
        if UIScreen.main.bounds.size.height == 568{
            return true
        }
        return false
    }

    
    func isIPhone6() -> Bool{
        if UIScreen.main.bounds.size.height == 667 || (UIScreen.main.bounds.size.height == 568 && UIScreen.main.nativeScale < UIScreen.main.scale && IS_OS_8_OR_LATER){
            return true
        }
        return false
    }
    
    func isIPhone6Plus() -> Bool{
        if UIScreen.main.bounds.size.height == 736 || (UIScreen.main.bounds.size.height == 667 && UIScreen.main.nativeScale < UIScreen.main.scale && IS_OS_8_OR_LATER){
            return true
        }
        return false
    }
}
