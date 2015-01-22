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
protocol TableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    func animateViewToBottom()
}
class MainScreenVC: UIViewController, UIScrollViewDelegate, TableViewDelegate {

    // MARK: - Properies und Variabeln
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    
    
    // Containers to hold the child controllers view
    var mapContainer: UIView!
    var tableViewContainer: UIView!
    

    // Buttons
    
    //Zeigt alle Kontakte des Users an, insbesondere wo diese sich befinden und wann sie dort waren
    var contactButton: UIButton!
    
    ///
    var shareYourLocationButton: UIButton!
    
    /// Zeigt die Favoriten/Meist besuchten Locations vom Nutzer an. Dort sieht man auch, wie lange man an einer Location war.
    var myLocationsButton: UIButton!
    
    /// Die momentane Location des Users wird auf der Karte angezeigt
    var locateMeButton: UIButton!
    
    
    //MARK:- Computet Properties
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
    
    //MARK:- Methoden
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup MapVC
        mapVC = MainScreenMapVC()
        self.addChildViewController(mapVC)
        var mapHeight:CGFloat!
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            mapHeight = Constants.screenWidth * Constants.kAspectRatioMapToTableViewIPad
        } else {
            mapHeight = Constants.screenWidth * Constants.kAspectRatioMapToTableViewIPhone
        }
        self.mapContainer = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, mapHeight))
        self.view.addSubview(self.mapContainer)
        self.mapContainer.addSubview(self.mapVC.view)
        self.mapVC.didMoveToParentViewController(self)
        
        
        //  Setup TableVC
        self.tableVC = MainScreenTableVC()
        self.tableVC.delegate = self
        self.addChildViewController(self.tableVC)
        
        self.tableViewContainer = UIView(frame: CGRectMake(0, Constants.screenHeight-Constants.tableViewHeight, Constants.screenWidth, Constants.tableViewHeight))
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
        mapVC.mapView.zoomIn()
    }
    
    func myLocationButtonPressed() {
        
    }
    
    func shareYourLocationButtonPressed(){
        // Zwischen den TableViews switchen
        self.tableViewIsExtended = !self.tableViewIsExtended
    }
    
    //TODO:- Wenn Map verschwindet, soll der entsprechende BUtton jeweils oben bleiben und nicht mitanimiert werden
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
        if (tableViewIsExtended){
            // tableView einklappen
            self.animateViewToBottom()
        }
    }
    
    func animateViewToTop(){
        self.tableViewIsExtended =  true
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            // transitionConstant: Höhe des TableViews mit allen Cells (Cells + HeaderView) - Höhe des momentanen TableViews
            var transitionConstant = numberOfRows * Constants.kCellHeight  + 70 - Constants.tableViewHeight
            
            let topSpace = Constants.topSpace
            let maxTransition = self.view.frame.height-Constants.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            //ganzen View nach oben verschieben + tableView-Höhe vergrössern
            self.view.frame = CGRectMake(0, -transitionConstant, Constants.screenWidth, self.view.frame.height+transitionConstant)
            //TableViewContainer.frame Höhe anpassen
            self.tableViewContainer.frame = CGRectMake(0, self.tableViewContainer.frame.origin.y,Constants.screenWidth, transitionConstant+Constants.tableViewHeight)
            
            let tableViewFrame = CGRectMake(0, 0, Constants.screenWidth, transitionConstant+Constants.tableViewHeight)
            self.tableVC.tableView.frame = CGRectMake(0, 0, Constants.screenWidth, transitionConstant+Constants.tableViewHeight)
        })
        
    }
    
    
    func animateViewToBottom(){
        self.tableViewIsExtended = false
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * Constants.kCellHeight - Constants.tableViewHeight
            
            let topSpace = Constants.topSpace
            let maxTransition = Constants.screenHeight-Constants.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            self.view.frame = CGRectMake(0, 0, Constants.screenWidth, UIScreen.mainScreen().bounds.height)
            self.tableVC.tableView.frame = CGRectMake(0, 0, Constants.screenWidth, Constants.tableViewHeight)
            self.tableViewContainer.frame = CGRectMake(0, self.tableViewContainer.frame.origin.y, Constants.screenWidth, Constants.tableViewHeight)
        })
    }
    
    
    // MARK:- TableView Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("Did Select row at IndexPath:\(indexPath.row)")
    
        
    }


}


