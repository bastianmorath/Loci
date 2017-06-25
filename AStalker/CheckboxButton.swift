//
//  CheckboxButton.swift
//  Loci
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//
// Diese UIButton-Subclass definiert einen "Checkbox"-Button. Der Status des imageViews wird der variable '.isChecked'  angepasst
import UIKit

class CheckboxButton: UIButton {
    
    //CircleView: Grauer Kreis
    var notSelectedView = DeselectedButtonView(frame: CGRect(x: 0, y: -6, width: 35, height: 35), type: .empty)
    //CheckmarkView: Roter Button mit Checkmark
    var selectedView = SelectedButtonView(frame: CGRect(x: 4, y: -2, width: 27, height: 27), type: .checkmark)
    
    //bool Property. Versteckt,r esp. zeigt die zwei Views an.
    var isChecked:Bool = false {
        didSet{
            if isChecked == true {
                notSelectedView.isHidden == true
                selectedView.isHidden = false
            } else {
                notSelectedView.isHidden == false
                selectedView.isHidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        self.addTarget(self, action: "buttonClicked:", for: UIControlEvents.touchUpInside)
        
        //Füge die beiden Views dem Button hinzu
        notSelectedView.isUserInteractionEnabled = false
        selectedView.isUserInteractionEnabled = false
        
        self.addSubview(notSelectedView)
        self.addSubview(selectedView)
        
        self.isUserInteractionEnabled = false
        self.isChecked = false
    }

}
