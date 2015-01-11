//
//  CheckmarkView.swift
//  AStalker
//
//  Created by Bastian Morath on 11/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class CheckmarkView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.opaque = false
            self.backgroundColor = UIColor.RedColor()
            self.hidden = true
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func drawRect(rect: CGRect) {
            super.drawRect( rect )
            
            // Get the Graphics Context
            var context = UIGraphicsGetCurrentContext();
            
            // Set the circle outerline-width
            //CGContextSetLineWidth(context, 1);
            
            // Set the circle outerline-colour
            UIColor.RedColor().setFill()
            CGContextFillEllipseInRect(context, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
    }
}

       