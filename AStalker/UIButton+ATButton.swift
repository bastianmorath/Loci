//
//  UIButton+ATButton.swift
//  Trainer
//
//  Created by Lukas Reichart on 06/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit

/**
*  Extend the UIButton with some factory methods for our custom Buttons.
*/
extension UIButton {
    
    enum ATButtonType {
        case Contact
        case Location
        case ContactLocation
    }
    
    enum ATColor {
        case Red
        case White
        case Grey
    }
    
    enum ATButtonLocation {
        case TopRight
        case TopLeft
    }
    
    
    class func ATButton( type: ATButtonType, color: ATColor, buttonLocation: ATButtonLocation? = nil) -> UIButton {
        var button = UIButton.buttonWithType( UIButtonType.Custom ) as UIButton
        
        //button.clipsToBounds = true
        button.layer.cornerRadius = 70
        button.setTranslatesAutoresizingMaskIntoConstraints( false )
        button.showsTouchWhenHighlighted = true
        switch color{
        case .Red:
            button.backgroundColor = UIColor.RedColor()
        case .White:
            button.backgroundColor = UIColor.WhiteColor()
        case .Grey:
            button.backgroundColor = UIColor.GreyColor()
        }
        
        
        switch type {
        case .Contact:
            button.setImage( UIImage( named: "Contacts.png"), forState: UIControlState.Normal )
        case .Location:
            button.setImage( UIImage( named: "MyLocations.png"), forState: UIControlState.Normal )
        case .ContactLocation:
            button.setImage( UIImage( named: "SharedLocations.png"), forState: UIControlState.Normal )
        default:
            button.setImage( UIImage(named: "EditIcon"), forState: UIControlState.Normal )
        }
        
//        if let location = buttonLocation {
//            self.positionButtonToLocation(location)
//        }
        
        // add a shadow to the button
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.blackColor().CGColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 5.0
        button.layer.shadowOffset = CGSizeMake( 1, 1 )
        
        
        return button
    }
    
    
    func positionButtonToLocation(location: ATButtonLocation ) {
        let views = ["button" : self]
        let metrics = ["margin": 25]
        
        var horizontalConstraint = ""
        var verticalConstraint = ""
        
        switch location {
        case .TopRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint = "V:|-margin-[button]"
        case .TopLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint = "V:|-margin-[button]"
        default:
            break
        }
        
        if let superview = self.superview {
            superview.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraint, options: nil, metrics: metrics, views: views ) )
            superview.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraint, options: nil, metrics: metrics, views: views ) )
        }
    }
}





