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
        case SingleLocation
        case ContactLocation
        case MultipleLocations
        case Share
    }
    
    enum ATColor {
        case Red
        case White
        case Grey
    }
    
    enum ATButtonLocation {
        case TopRight
        case TopLeft
        case BottomLeft
        case BottomRight
    }
    
    
    class func ATButton( type: ATButtonType, color: ATColor) -> UIButton {
        var button = UIButton.buttonWithType( UIButtonType.Custom ) as UIButton
        
        //button.clipsToBounds = true
        button.layer.cornerRadius = 28
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
        
        var imageView = UIImageView(frame: CGRectMake(11, 9, 35, 35))
        switch type {
        case .Contact:
            imageView.image = UIImage(named: "Contacts.png")
        case .SingleLocation:
            imageView.image = UIImage(named: "Location.png")
        case .ContactLocation:
            imageView.image = UIImage(named: "SharedLocations.png")
        case .MultipleLocations:
            imageView.image = UIImage(named: "MyLocations.png")
        case .Share:
            var label = UILabel(frame: CGRectMake(10, 12, 50, 35))
            label.text = "Share"
            label.font = UIFont.ATBoldFont()
            label.textColor = UIColor.RedColor()
            button.addSubview(label)
            return button
        default:
            imageView.image = UIImage(named: "Contacts.png")
        }
        button.addSubview(imageView)

        

        
    
        return button
    }
    
    
    func positionButtonToLocation(location: ATButtonLocation ) {
        let views = ["button" : self]
        let metrics = ["margin": 25]
        
        var horizontalConstraint = ""
        var verticalConstraint = ""
        var heightConstraint = "V:[button(56)]"
        var widthConstraint = "H:[button(56)]"

        switch location {
        case .TopRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint = "V:|-margin-[button]"
        case .TopLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint = "V:|-margin-[button]"
        case .BottomLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint = "V:[button]-margin-|"
        case .BottomRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint = "V:[button]-margin-|"
        default:
            break
        }
        
        if let superview = self.superview {
            superview.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(horizontalConstraint, options: nil, metrics: metrics, views: views ) )
            superview.addConstraints( NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraint, options: nil, metrics: metrics, views: views ) )
            superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(heightConstraint, options: nil, metrics: nil, views: views))
            superview.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(widthConstraint, options: nil, metrics: nil, views: views))
        }
    }
}





