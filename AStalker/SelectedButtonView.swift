//
//  CheckmarkView.swift
//  Loci
//
//  Created by Bastian Morath on 11/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
//  Ein UIView, welcher einen Kreis mit Herz oder Checkmark darstellt. Er präsentiert den UIButton.isSelected-State

import UIKit

class SelectedButtonView: UIView {
    
    enum Type {
        case Checkmark
        case Heart
    }
    
    //Speichert den Type des Views
    let type = Type.Checkmark
    
    var imageView = UIImageView()
    
    init(frame: CGRect, type: Type) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.type = type
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
        
        switch self.type {
        case .Checkmark:
            self.imageView = UIImageView(image: UIImage(named: "Checkmark.png"))
            self.imageView.userInteractionEnabled = false
            self.imageView.frame = rect
            self.addSubview(self.imageView)
            
        case .Heart:
            self.imageView = UIImageView(image: UIImage(named: "Heart_White.png"))
            self.imageView.userInteractionEnabled = false
            self.imageView.frame = rect
            self.addSubview(self.imageView)
        }
    }
}

       