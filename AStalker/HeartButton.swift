//
//  HeartButton.swift
//  AStalker
//
//  Created by Bastian Morath on 15/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class HeartButton: UIButton{
    
    //CircleView: Grauer Kreis mit Herz
    var notSelectedView = DeselectedButtonView(frame: CGRectMake(0, -6, 35, 35), type: .Heart)
    //CheckmarkView: Roter Button mit Heart
    var selectedView = SelectedButtonView(frame: CGRectMake(4, -2, 27, 27), type: .Heart)
    
    //bool Property. Versteckt, resp. zeigt die zwei Views an.
    var isChecked:Bool = false {
        didSet{
            if isChecked == true {
                notSelectedView.hidden == true
                selectedView.hidden = false
            } else {
                notSelectedView.hidden == false
                selectedView.hidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Füge die beiden Views dem Button hinzu
        notSelectedView.userInteractionEnabled = false
        selectedView.userInteractionEnabled = false
        
        self.addSubview(notSelectedView)
        self.addSubview(selectedView)
        
        self.userInteractionEnabled = false
        self.isChecked = false
    }

}