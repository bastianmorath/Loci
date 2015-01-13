//
//  CheckmarkView.swift
//  AStalker
//
//  Created by Bastian Morath on 11/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class CheckmarkView: UIView {
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        var bPath:UIBezierPath = UIBezierPath(rect: rect)
        let circleFillColor = UIColor.RedColor()
        var cPath: UIBezierPath = UIBezierPath(ovalInRect: rect)
        circleFillColor.set()
        cPath.fill()
        
        self.imageView = UIImageView(image: UIImage(named: "Checkmark.png"))
        self.imageView.userInteractionEnabled = false
        self.imageView.frame = rect
        self.addSubview(self.imageView)
    }
}

       