//
//  LITableViewController.swift
//  AStalker
//
//  Created by Bastian Morath on 02/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

// Subclass of UIViewController to handle TableViewControllers of MainScreenVC
import UIKit

class LIViewViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    
    var delegate:TableViewAndMapDelegate! = nil
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        
        self.view.frame = Constants.tableViewFrameNotExtended
        
        self.tableView = UITableView(frame: self.view.frame, style: .Plain)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.bounces = false
        self.view.addSubview(tableView)
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Constants.kCellHeight
    }
    
    //MARK:- Scroll View Delegate
    
    // Detecte, wenn der User zuoberst angekommen ist und weiter nach oben scrollt
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        var translation = scrollView.panGestureRecognizer.translationInView(scrollView.superview!);
        if  translation.y > 0 && scrollView.contentOffset.y == 0 {
            // Geklickte Row nach oben  scrollen
            delegate.animateViewToBottom()
        }
    }
}
