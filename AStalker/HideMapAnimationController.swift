//
//  HideMapAnimationController.swift
//  AStalker
//
//  Created by Bastian Morath on 14/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit

class HideMapAnimationController: AnimationController {
    
    override func animatePushWithTransitionContext( transitionContext: UIViewControllerContextTransitioning ){
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey( UITransitionContextFromViewControllerKey )
        var toViewController = transitionContext.viewControllerForKey( UITransitionContextToViewControllerKey )
        
        
        // Add the 'to' view to the hirarchy

        containerView.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view )
        containerView.bringSubviewToFront(fromViewController!.view)

        
        UIView.animateWithDuration( self.transitionDuration(transitionContext), animations: {
            let translation = CGAffineTransformMakeTranslation(0, 400)
        

            fromViewController?.view.transform = translation
            }, completion:{ finished in
               transitionContext.completeTransition( true )
        })
}
    
    
    override func animatePopWithTransitionContext( transitionContext: UIViewControllerContextTransitioning ) {
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey( UITransitionContextFromViewControllerKey )
        var toViewController = transitionContext.viewControllerForKey( UITransitionContextToViewControllerKey )
        
        // Add the 'to' view to the hirarchy
        containerView.insertSubview( toViewController!.view, belowSubview: fromViewController!.view )
        
        // scale the 'from' view down until it disappears
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            fromViewController!.view.transform = CGAffineTransformMakeScale( 0.0, 0.0 )
            }, completion: { finished in
                transitionContext.completeTransition( true )
        })
    }
}
