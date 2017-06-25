//
//  CircleView.swift
//  Loci
//
//  Created by Bastian Morath on 11/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
//  Ein UIView, welcher einen Kreis mi oder ohne Herz darstellt. Er präsentiert den !(UIButton.isSelected)-State 

import UIKit

class DeselectedButtonView: UIView {

    enum Type {
        case empty
        case heart
    }
    
    //Speichert den Type des Views
    var type = Type.empty
    
     init(frame: CGRect, type: Type) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.type = type
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Get the Graphics Context
        let context = UIGraphicsGetCurrentContext();
        
        // Set the circle outerline-width
        context?.setLineWidth(1);
        
        // Set the circle outerline-colour
        UIColor.black.set()
        
        // Create Circle
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
       

        if self.type == .heart{
            UIColor.lightGray.set()
            //Herz hinzufügen
            let imageView = UIImageView(image: UIImage(named: "Heart_LightGrey.png"))
            imageView.frame = CGRect(x: 4, y: 4, width: 27, height: 27)
            imageView.isUserInteractionEnabled = false
            //imageView.frame = rect
            self.addSubview(imageView)
        }
        // Draw
        context?.strokePath();
    }
    
}
