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
        self.mapVC.view.userInteractionEnabled = false
        self.addChildViewController(controller)
        self.container.insertSubview(controller.view, atIndex: 0)
        UIView.animateWithDuration( 0.6, animations: {
            let translation = CGAffineTransformMakeTranslation(0, Constants.screenHeight-Constants.topSpace)
            
            self.homeViewContainer.transform = translation
        })
        controller.didMoveToParentViewController(self)
    }
}

extension UIViewController{
    func dismissViewController(){
        mainScreenVC.mapVC.view.userInteractionEnabled = true
        
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            let translation = CGAffineTransformMakeTranslation(0, 0)
            
            mainScreenVC.homeViewContainer.transform = translation
            
            }, completion: { (Bool) -> Void in
                self.willMoveToParentViewController(nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
        
    }
}