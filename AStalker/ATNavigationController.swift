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
    
   /*    returns: optional animation controller
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
        
        // Transition to 'AddFriendsVC'
        if operation == UINavigationControllerOperation.Push && toVC.isKindOfClass(AddFriendsVC) {
            var vC = toVC as AddFriendsVC
            vC.animationController.isPresenting = true
            return vC.animationController
        }
        
        // Pop from 'AddFriendsVC'
        if operation == UINavigationControllerOperation.Pop && fromVC.isKindOfClass(AddFriendsVC){
            var vC = fromVC as AddFriendsVC
            vC.animationController.isPresenting = false
            return vC.animationController
        }
        
        return nil
    }
}
