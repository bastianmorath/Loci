//
//  ATAnimationController.swift
//  Trainer
//
//  Created by Lukas Reichart on 24.11.14.
//  Copyright (c) 2014 Antum. All rights reserved.
//

import Foundation
import UIKit

/**
*  The ATAnimationController class is a base class for all Custom Animations of Antum Trainer.
*  All View Controller Transitioning animations should inherit from this class and override the two properties defined by the UIViewControllerAnimatedTransitioning protocol.
*/
class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = false
    var oldFrame: CGRect?
    
    // a dictionary that can be used to store data
    // that is needed by the animation
    var data: [String: AnyObject] = [String: AnyObject]()
    
    /**
    main function of the UIViewControllerAnimatedTransitioning Protocol
    */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting{
            animatePushWithTransitionContext( transitionContext )
        }
        else {
            animatePopWithTransitionContext( transitionContext )
        }
    }
    
    
    func animatePushWithTransitionContext( transitionContext: UIViewControllerContextTransitioning ){
        var containerView = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey( UITransitionContextFromViewControllerKey )
        var toViewController = transitionContext.viewControllerForKey( UITransitionContextToViewControllerKey )
        
        
        // Add the 'to' view to the hirarchy
        containerView.insertSubview(toViewController!.view, aboveSubview: fromViewController!.view )
        toViewController?.view.bringSubviewToFront(fromViewController!.view)
        
        UIView.animateWithDuration( self.transitionDuration(transitionContext), animations: {
            let translation = CGAffineTransformMakeTranslation(0, 50)

            fromViewController?.view.transform = translation
            }, completion:{ finished in
                transitionContext.completeTransition( true )
        })
    }
    
    
    func animatePopWithTransitionContext( transitionContext: UIViewControllerContextTransitioning ) {
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
    
    /**
    :returns: returns the duration of the animation
    */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return  1.0 as NSTimeInterval
    }
}