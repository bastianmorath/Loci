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
    class func RedColor() -> UIColor {
        return UIColor(red: 237 / 255, green: 28 / 255, blue: 36 / 255, alpha: 1)
    }
    
    class func WhiteColor() -> UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    class func BlueColor() -> UIColor {
        return UIColor(red: 4 / 255, green: 123 / 255, blue: 235 / 255, alpha: 1)
    }
    
    class func GreenColor() -> UIColor {
        return UIColor(red: 57 / 255, green: 178 / 255, blue: 48 / 255, alpha: 1)
    }
    
    class func GreyColor() -> UIColor {
        return UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1)
    }
    
    
    /************************* END Convenience Functions  ***********************************/
    
}












