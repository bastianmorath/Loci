//
//  ContainerViewController.swift
//  AStalker
//
//  Created by Florian Morath on 10.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

/* This class holds all it's child ViewControllers and their views in ContainerViews */

/*
tableView ausklappen:
Der TableView wird mit einer Swipe-Geste im TableView nach oben ausgeklappt. Er wird durch eine Swipe-Geste in der Map oder im TableView nach unten eingeklappt, SOFERN im TableView ganz nach oben gescrollt wird. Sonst wird zuerst nach oben gescrollt.
Die Gesture-Recognizer werden vom TableVC und MapVC gehandelt. Wird in einem der beiden Controller geswiped, wird eine Notification in den anderen Controller gesendet, um dort die Bool-Property '.tableViewIsExtended' zu inversen
*/
import Foundation
import UIKit


// Protocol, um vom TableVC die Nachricht zu bekommen, wenn eine cell gedrückt wurde
protocol TableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}
class MainScreenVC: UIViewController, UIScrollViewDelegate, TableViewDelegate {
    
    
    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    let kAspectRatioMapToTableViewIPad: CGFloat = 1.04
    
    
    // MARK: - Properies und Variabeln
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!

    
    // Containers to hold the child controllers view
    var mapContainer: UIView!
    var tableViewContainer: UIView!
    
    // Gibt an, ob der TableView ausgeklappt ist oder nicht.
    var tableViewIsExtended:Bool = false {
        willSet{
            if newValue == true {
                self.mapVC.mapView.userInteractionEnabled = false
                self.tableVC.tableView.scrollEnabled = true
                self.tableVC.tableView.userInteractionEnabled = true
            } else {
                self.mapVC.mapView.userInteractionEnabled = true
                self.tableVC.tableView.scrollEnabled = false
                self.tableVC.tableView.userInteractionEnabled = false
            }
        }
    }
    
    // Height of TableView
    var tableViewHeight:CGFloat {
        get{
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
                return UIScreen.mainScreen().bounds.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPad
            } else {
                return UIScreen.mainScreen().bounds.height-self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
            }
        }
    }
    
    
    
    // Buttons
    
    //Zeigt alle Kontakte des Users an, insbesondere wo diese sich befinden und wann sie dort waren
    var contactButton: UIButton!
    
    /// 
    var shareYourLocationButton: UIButton!
    
    /// Zeigt die Favoriten/Meist besuchten Locations vom Nutzer an. Dort sieht man auch, wie lange man an einer Location war.
    var myLocationsButton: UIButton!
    
    /// Die momentane Location des Users wird auf der Karte angezeigt
    var locateMeButton: UIButton!
    
    //MARK:- Methoden
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup MapVC
        mapVC = MainScreenMapVC()
        self.addChildViewController(mapVC)
        var mapHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPad
        } else {
            mapHeight = self.view.frame.size.width*kAspectRatioMapToTableViewIPhone
        }
        self.mapContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, mapHeight))
        self.view.addSubview(self.mapContainer)
        self.mapContainer.addSubview(self.mapVC.view)
        self.mapVC.didMoveToParentViewController(self)
        
        
        //  Setup TableVC
        self.tableVC = MainScreenTableVC()
        self.tableVC.delegate = self
        self.addChildViewController(self.tableVC)
        
        self.tableViewContainer = UIView(frame: CGRectMake(0, self.view.frame.height-self.tableViewHeight, self.view.frame.size.width, self.tableViewHeight))
        tableViewContainer.addSubview(self.tableVC.view)
        self.view.addSubview(self.tableViewContainer)
        tableVC.didMoveToParentViewController(self)
        
        self.tableViewIsExtended = false
        
        // Setup Buttons
        myLocationsButton = UIButton.ATButton(.MultipleLocations, color: .White)
        myLocationsButton.addTarget(self, action: "myLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(myLocationsButton)
        myLocationsButton.positionButtonToLocation(.TopLeft)
        
        contactButton = UIButton.ATButton(.Contact, color: .White)
        contactButton.addTarget(self, action: "contactButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(contactButton)
        contactButton.positionButtonToLocation(.TopRight)
        
        shareYourLocationButton = UIButton.ATButton(.ContactLocation, color: .Grey)
        shareYourLocationButton.addTarget(self, action: "shareYourLocationButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.tableViewContainer.addSubview(shareYourLocationButton)
        shareYourLocationButton.positionButtonToLocation(.TopHalfLeft)
        
        locateMeButton = UIButton.ATButton(.SingleLocation, color: .White)
        locateMeButton.addTarget(self, action: "locateMeButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.mapContainer.addSubview(locateMeButton)
        locateMeButton.positionButtonToLocation(.BottomRight)
        
        //Swipe Gesture Up
        var swipeUpTableViewGesture = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUpTableViewGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpTableViewGesture)
        
        
        //Swipe Gesture Down
        var swipeDownMap = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDownMap.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownMap)
    }
    
    // MARK: - Button Handling
    
    func locateMeButtonPressed() {
        mapVC.zoomIn()
    }
    
    func myLocationButtonPressed() {
        
    }
    
    func shareYourLocationButtonPressed(){
        // Zwischen den TableViews switchen
        self.tableViewIsExtended = !self.tableViewIsExtended
    }
    
    func contactButtonPressed() {
        var addFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addFriendsVC") as AddFriendsVC
        self.navigationController?.pushViewController(addFriendsVC, animated: true)
        
    }
    
    
    // MARK:- Swipe-Gesture
    func swipeUp(){
        if !tableViewIsExtended{
            // tableView ausklappen
            self.animateViewToTop()
            
        }
    }
    
    func swipeDown(){
        //TODO: Momentan kann nur von der Map aus heruntergeswiped werden
        if (tableViewIsExtended /*&& self.tableVC.tableView.contentOffset.y == 0*/){
            // tableView einklappen
            self.animateViewToBottom()
        }
    }
    
    func animateViewToTop(){
        self.tableViewIsExtended =  true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            // transitionConstant: Höhe des TableViews mit allen Cells (Cells + HeaderView) - Höhe des momentanen TableViews
            var transitionConstant = numberOfRows * 52  + 61 - self.tableViewHeight
            
            let topSpace = 82 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            self.shareYourLocationButton.backgroundColor = UIColor.RedColor()
            //ganzen View nach oben verschieben + tableView-Höhe vergrössern
            self.view.frame = CGRectMake(0, -transitionConstant, self.view.frame.width, self.view.frame.height+transitionConstant)
            //TableViewContainer.frame Höhe anpassen
            self.tableViewContainer.frame = CGRectMake(0, self.tableViewContainer.frame.origin.y, self.view.frame.width, transitionConstant+self.tableViewHeight)
            let tableViewFrame = CGRectMake(0, 0, self.view.frame.width, transitionConstant+self.tableViewHeight)
            //self.tableVC.view.frame = CGRectMake(0, 0, self.view.frame.width, transitionConstant+self.tableViewHeight)
            self.tableVC.tableView.frame = CGRectMake(0, 0, self.view.frame.width, transitionConstant+self.tableViewHeight)
        })
    }
    
    
    func animateViewToBottom(){
        self.tableViewIsExtended = false
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
                var transitionConstant = numberOfRows * 52 - self.tableViewHeight
                
                let topSpace = 100 as CGFloat
                let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
                transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
                self.shareYourLocationButton.backgroundColor = UIColor.GreyColor()
                self.view.frame = CGRectMake(0, 0, self.view.frame.width, UIScreen.mainScreen().bounds.height)
                self.tableVC.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.tableViewHeight)
                self.tableViewContainer.frame = CGRectMake(0, self.tableViewContainer.frame.origin.y, self.view.frame.width, self.tableViewHeight)
                
                // Scroll to Top of TableView
                self.tableVC.tableView.contentOffset = CGPointMake(0, 0-self.tableVC.tableView.contentInset.top)
        })
    }
    
    // MARK:- TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("Did Select row at IndexPath:\(indexPath.row)")
        
    }
}


