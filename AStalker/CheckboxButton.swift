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
    var notSelectedView = CircleView(frame: CGRectMake(0, 0, 25, 25))
    //CheckmarkView: Roter Button mit Checkmark
    var selectedView = CheckmarkView(frame: CGRectMake(4, 4, 17, 17))
    
    //bool Property. Versteckt,r esp. zeigt die zwei Views an.
    var isChecked:Bool = false {
        didSet{
            if isChecked == true {
                println("isChecked = true")
                notSelectedView.hidden == true
                selectedView.hidden = false
            } else {
                println("isChecked = false")
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

   //TODO: UNterscheiden, ob der Button oder die Cell angeklickt wurde
//    func buttonClicked(sender: UIButton){
//        println(isChecked)
//        if(sender == self){
//            if isChecked {isChecked = false}
//            else {isChecked = true}
//        }
//    }
}
