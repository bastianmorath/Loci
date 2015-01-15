//
//  CheckboxButton.swift
//  AStalker
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
// Diese UIButton-Subclass definiert einen "Checkbox"-Button. Der Status des imageViews wird der variable '.isChecked'  angepasst
import UIKit

class CheckboxButton: UIButton {
    
    //CircleView: Grauer Kreis
    var notSelectedView = DeselectedButtonView(frame: CGRectMake(0, -6, 35, 35), type: .Empty)
    //CheckmarkView: Roter Button mit Checkmark
    var selectedView = SelectedButtonView(frame: CGRectMake(4, -2, 27, 27), type: .Checkmark)
    
    //bool Property. Versteckt,r esp. zeigt die zwei Views an.
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
