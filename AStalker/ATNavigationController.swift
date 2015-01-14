//
//  ATNavigationController.swift
//  Trainer
//
//  Created by Lukas Reichart on 22.11.14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit

/**
*  the ATNavigationController is a UINavigationController for the Antum Trainer app.
Especially it supports custom transitioning between ATViewControllers.
*/
class ATNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.setNavigationBarHidden( true, animated: false )
        self.delegate = self
    }
    
    /**
    if the toVC is a sublcass of ATViewController it may defined a custom ATAnimationController.
    If ATAnimtionController is defined we return it
    
    returns: optional animation controller
    */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Transition to 'ShareLcoationVC'
        if operation == UINavigationControllerOperation.Push && toVC.isKindOfClass(ShareLocationVC) {
            var vC = toVC as ShareLocationVC
            vC.animationController.isPresenting = true
            return vC.animationController
            
        }
        
        // Pop from 'ShareLocationVC'
        if operation == UINavigationControllerOperation.Pop && fromVC.isKindOfClass(ShareLocationVC){
            var vC = fromVC as ShareLocationVC
            vC.animationController.isPresenting = false
            return vC.animationController
        }
        
        return nil
    }
}
