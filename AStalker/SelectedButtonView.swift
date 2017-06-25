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
        case checkmark
        case heart
    }
    
    //Speichert den Type des Views
    var type = Type.checkmark
    
    var imageView = UIImageView()
    
    init(frame: CGRect, type: Type) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.type = type
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        var bPath:UIBezierPath = UIBezierPath(rect: rect)
        let circleFillColor = UIColor.RedColor()
        let cPath: UIBezierPath = UIBezierPath(ovalIn: rect)
        circleFillColor.set()
        cPath.fill()
        
        switch self.type {
        case .checkmark:
            self.imageView = UIImageView(image: UIImage(named: "Checkmark.png"))
            self.imageView.isUserInteractionEnabled = false
            self.imageView.frame = rect
            self.addSubview(self.imageView)
            
        case .heart:
            self.imageView = UIImageView(image: UIImage(named: "Heart_White.png"))
            self.imageView.isUserInteractionEnabled = false
            self.imageView.frame = rect
            self.addSubview(self.imageView)
        }
    }
}

       
