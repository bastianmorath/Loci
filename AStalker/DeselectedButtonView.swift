//
//  CircleView.swift
//  AStalker
//
//  Created by Bastian Morath on 11/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
//  Ein UIView, welcher einen Kreis mi oder ohne Herz darstellt. Er präsentiert den !(UIButton.isSelected)-State 

import UIKit

class DeselectedButtonView: UIView {

    enum Type {
        case Empty
        case Heart
    }
    
    //Speichert den Type des Views
    let type = Type.Empty
    
     init(frame: CGRect, type: Type) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.type = type
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        var context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 1);
        
        // Set the circle outerline-colour
        UIColor.blackColor().set()
        
        // Create Circle
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
       

        if self.type == .Heart{
            UIColor.lightGrayColor().set()
            //Herz hinzufügen
            var imageView = UIImageView(image: UIImage(named: "Heart_LightGrey.png"))
            imageView.frame = CGRectMake(4, 4, 27, 27)
            imageView.userInteractionEnabled = false
            //imageView.frame = rect
            self.addSubview(imageView)
        }
        // Draw
        CGContextStrokePath(context);
    }
    
}
