//
//  UIViewController + Navigation.swift
//  AStalker
//
//  Created by Bastian Morath on 23/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

var mainScreenVC: MainScreenVC!


extension MainScreenVC{
    func addViewController(controller: UIViewController){
        mainScreenVC = self
        self.mapVC.mapView.scrollEnabled = false
        self.mapIsAtBottom = true
        self.mapVC.mapIsAtBottom = true
        self.addChildViewController(controller)
        self.container.insertSubview(controller.view, atIndex: 0)
        UIView.animateWithDuration( 0.3, animations: {
            let translation = CGAffineTransformMakeTranslation(0, Constants.screenHeight-Constants.mapHeight)
            
            self.homeViewContainer.transform = translation
        })
        controller.didMoveToParentViewController(self)
    }
}


extension UIViewController{
    func dismissViewController(){
        mainScreenVC.mapVC.mapView.scrollEnabled = true
        mainScreenVC.mapIsAtBottom = false
        mainScreenVC.mapVC.mapIsAtBottom = false
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let translation = CGAffineTransformMakeTranslation(0, 0)
            
            mainScreenVC.homeViewContainer.transform = translation
            
            }, completion: { (Bool) -> Void in
                self.willMoveToParentViewController(nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
        
    }
}