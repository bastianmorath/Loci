//
//  LITableViewController.swift
//  AStalker
//
//  Created by Bastian Morath on 02/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

// Subclass of UIViewController to handle TableViewControllers of MainScreenVC
import UIKit

class LIViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate {
    
    var delegate:TableViewAndMapDelegate! = nil
    
    var tableView:UITableView!
    
    //Speichert den Indexpath der angeklickten Cell (falls eine angeklickt ist), welche dann vergrössert wird und einen MapView anzeigt.
    var selectedRowIndexPath: IndexPath?
    
    override func viewDidLoad() {
        
        self.view.frame = Constants.tableViewFrameNotExtended
        
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.bounces = false
        self.view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //indexPath is NSMutableIndexPath, so create an indexPath
        let index = IndexPath(row: indexPath.row, section: indexPath.section)
        
        if self.selectedRowIndexPath == index{
            return Constants.screenHeight - Constants.topSpace
        }
        return Constants.kCellHeight
    }
    
    //MARK:- Scroll View Delegate
    
    // Detecte, wenn der User zuoberst angekommen ist und weiter nach oben scrollt
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!);
        if  translation.y > 0 && scrollView.contentOffset.y == 0 {
            // Geklickte Row nach oben  scrollen
            delegate.animateViewToBottom()
        }
    }
}
