//
//  ShareYourLocationSegue.swift
//  AStalker
//
//  Created by Bastian Morath on 13/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit


class ShareYourLocationSegue: UIStoryboardSegue {
    override func perform () {
        let src = self.sourceViewController as MainScreenVC
        let dst = self.destinationViewController as ShareLocationVC

        
        src.presentViewController(dst, animated: true, completion: nil)
       
        
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            src.mapContainer.frame = CGRectMake(0, 400, 320, src.view.frame.height)
        })
    }
}
