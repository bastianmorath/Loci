//
//  UIColor+AntumColor.swift
//  Trainer
//
//  Created by Lukas Reichart on 05.11.14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit

/**
*  This UIColor extension is used to provide a convenient way to access the app's color settings.
*  The Color are stored as hex values in the "color.plist" file.
*/
extension UIColor{

    /************************* BEGIN Convenience Functions  ***********************************/
    class func RedColor() -> UIColor? {
        return UIColor(red: 237, green: 27, blue: 36, alpha: 1)
    }
    
    class func WhiteColor() -> UIColor? {
        return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    class func BlueColor() -> UIColor? {
        return UIColor(red: 5, green: 122, blue: 235, alpha: 1)
    }
    
    class func GreenColor() -> UIColor? {
        return UIColor(red: 57, green: 178, blue: 47, alpha: 1)
    }
    
    class func GreyColor() -> UIColor? {
        return UIColor(red: 141, green: 141, blue: 141, alpha: 1)
    }
    
    
    /************************* END Convenience Functions  ***********************************/
    
}












