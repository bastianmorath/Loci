//
//  LociButton.swift
//  AStalker
//
//  Created by Bastian Morath on 03/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

let kMargin = 18 as CGFloat
let kSize = 56 as CGFloat

class LociButton: UIButton {
    
    
    
    /**
    Enumeration über Button-Typen. Der Typ wird durch das angezeigte Icon definiert.
    
    - Contact:           Zwei Kontakt-Männchen
    - SingleLocation:    Ein Location-Icon
    - ContactLocation:   Ein LocationIcon und ein KontaktIcon
    - MultipleLocations: Zwei Location-Icons
    - Share:             Share-Text
    */
    enum ATButtonType {
        case contact
        case singleLocation
        case contactLocation
        case multipleLocations
        case share
        case closeArrow
    }
    
    enum ATColor {
        case red
        case white
        case grey
    }
    
    /**
    Enumeration über den Ort des Buttons.
    
    - TopHalfLeft: Das Icon wird am oberen linken Rand des SuperViews angezeigt, wobei die Hälfte des Icons darüber hinaus ist.
    
    */
    
    enum ATButtonLocation {
        case topRight
        case topLeft
        case bottomLeft
        case topHalfLeft
        case topHalfRight
        case bottomRight
    }
    
    var buttonLocation: ATButtonLocation?
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
     convenience init(type: ATButtonType, color: ATColor){
        self.init(frame: CGRect(x: 0,y: 0,width: 35,height: 35))
     
        self.layer.cornerRadius = CGFloat(kSize / 2)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsTouchWhenHighlighted = false
        switch color{
        case .red:
            self.backgroundColor = UIColor.RedColor()
        case .white:
            self.backgroundColor = UIColor.WhiteColor()
        case .grey:
            self.backgroundColor = UIColor.GreyColor()
        }
        
        let imageView = UIImageView(frame: CGRect(x: 11, y: 9, width: 35, height: 35))
        switch type {
        case .contact:
            imageView.image = UIImage(named: "Contacts.png")
        case .singleLocation:
            imageView.image = UIImage(named: "LocateMe.png")
            imageView.frame = CGRect(x: 3, y: 3, width: 50, height: 50)
            self.backgroundColor = UIColor.clear
        case .contactLocation:
            imageView.image = UIImage(named: "SharedLocations.png")
        case .multipleLocations:
            imageView.image = UIImage(named: "MyLocations.png")
        case .share:
            let label = UILabel(frame: CGRect(x: 10, y: 12, width: 50, height: 35))
            label.text = "Share"
            label.font = UIFont.ATBoldFont()
            label.textColor = UIColor.RedColor()
            self.addSubview(label)
            return
        case .closeArrow:
            imageView.image = UIImage(named: "Close.png")
            imageView.frame = CGRect(x: 3, y: 3, width: 30, height: 30)
            self.backgroundColor = UIColor.clear
        default:
            imageView.image = UIImage(named: "Contacts.png")
        }
        self.addSubview(imageView)
        
    }
    
    /**
    Diese Funktion passt den Ort des Buttons an. Wird automatisch durch vordefinierte Constraints am SuperView angepasst.
    ACHTUNG: FUnktion erst anwenden, NACHDEM der Button dem SuperView hinzugefügt wurde
    :param: location Location-Enumeration
    */
    func positionButtonToLocation(_ location: ATButtonLocation) {
        self.positionToView(superview, location: location)
        
    }
    
    // Takes the current location and position it to the view
    func positionToView(_ view: UIView!, location: ATButtonLocation){
        self.buttonLocation = location
        
        //Remove and re-add the button to its superView to remove constraints and update it later in this method
        let superView = self.superview
        self.removeFromSuperview()
        superView?.addSubview(self)
        
        let views = ["button" : self]
        /// margin: Abstand der Buttons zum Rand
        /// topSpace: Abstand des shareLocationButtons zum oberen Rand -> floated zwischen TableView und Map
        let metrics = ["margin": kMargin,"topSpace":Constants.screenWidth * Constants.kAspectRatioMapToTableView - kSize/2]
        
        //Höhe und Breite des Buttons
        let heightConstraint = "V:[button(\(kSize))]"
        let widthConstraint = "H:[button(\(kSize))]"
        if let superview = self.superview {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: heightConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: widthConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: views))
        }
        var horizontalConstraint = "H:[button(\(kSize))]"
        var verticalConstraint = "V:[button(\(kSize))]"
        switch location {
        case .topRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint =   "V:|-margin-[button]"
        case .topLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint =   "V:|-margin-[button]"
        case .bottomLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint =   "V:[button]-margin-|"
        case .topHalfLeft:
            horizontalConstraint = "H:|-margin-[button]"
            verticalConstraint = "V:|-topSpace-[button]"
        case .topHalfRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint = "V:|-topSpace-[button]"
        case .bottomRight:
            horizontalConstraint = "H:[button]-margin-|"
            verticalConstraint =   "V:[button]-margin-|"
        default:
            break
        }
        
        if let superview = self.superview {
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraint, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
            
        }

    }
    
    
}
