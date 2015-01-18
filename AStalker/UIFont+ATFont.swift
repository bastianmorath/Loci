//
//  UIFont+ATFont.swift
//  Trainer
//
//  Created by Lukas Reichart on 20.11.14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit

/**
*  extension defining convenience functions for loading the app fonts
*/
extension UIFont{
  
    class func ATTitleFont() -> UIFont? {
        return UIFont( name: "UniversLTStd-Light", size: 12.0 )
    }
    class func ATTableViewSmallFont() -> UIFont? {
        return UIFont( name: "UniversLTStd-Light", size: 20.0 )
    }
    class func ATTableViewFont() -> UIFont? {
        return UIFont( name: "UniversLTStd-Light", size: 24.0 )
    }
    
    class func ATFont() -> UIFont? {
        return UIFont( name: "UniversLTStd-Light", size: 10.0 )
    }
    
    class func ATBoldFont() -> UIFont? {
        return UIFont( name: "UniversLTStd-Bold", size: 13.0 )
    }
    
    class func ATButtonFont() -> UIFont? {
        return UIFont( name: "UniversLTStd", size: 11.0 )
    }
  
  /**
  Debug function: Logs all fonts available to the command line.
  */
  class func createDebugOutput() {
    for family in UIFont.familyNames() as [String] {
      println( family )
      for name in UIFont.fontNamesForFamilyName( family ) {
        println( name )
      }
    }
  }
  
}