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

class MainScreenVC: UIViewController, UIScrollViewDelegate {
    
    
    //Verhältnis vom mapContainer zum TableView: iPhone 5-6Plus
    let kAspectRatioMapToTableViewIPhone: CGFloat = 1.24
    
    //Verhältnis vom mapContainer zum TableView: iPad
    let kAspectRatioMapToTableViewIPad: CGFloat = 1.04
    
    
    
    
    // MARK: - Properies und Variabeln
    
    // child controllers
    var mapVC: MainScreenMapVC!
    var tableVC: MainScreenTableVC!
    
    // Location, welche dem ShareLocationVC übergeben wird
    var locationToShare:Location?
    
    // Containers to hold the child controllers view
    var mapContainer: UIView!
    var tableViewContainer: UIView!
    
    // Gibt an, ob der TableView ausgeklappt ist oder nicht.
    var tableViewIsExtended:Bool = false {
        willSet{
            
            if newValue == true {
                self.mapVC.mapView.userInteractionEnabled = false
                self.tableVC.tableView.scrollEnabled = true
            } else {
                self.mapVC.mapView.userInteractionEnabled = true
                self.tableVC.tableView.scrollEnabled = false
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
    
    /// Der User shared seine Location und kann auswählen, mit welchen Kontakten er das machen will
    var shareYourLocationButton: UIButton!
    
    /// Zeigt die Favoriten/Meist besuchten Locations vom Nutzer an. Dort sieht man auch, wie lange man an einer Location war.
    var myLocationsButton: UIButton!
    
    /// Die momentane Location des Users wird auf der Karte angezeigt
    var locateMeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup MainScreenMapVC
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
        
        
        //  Setup TableViewController
        self.tableVC = MainScreenTableVC()
        self.addChildViewController(self.tableVC)
        
        self.tableViewContainer = UIView(frame: CGRectMake(0, self.view.frame.height-self.tableViewHeight, self.view.frame.size.width, self.tableViewHeight))
        tableViewContainer.addSubview(self.tableVC.view)
        self.view.addSubview(self.tableViewContainer)
        tableVC.didMoveToParentViewController(self)

        // TableView.isScrollable = false, wird nur aktiviert, wenn der TwableView ausgeklappt wurde
        self.tableVC.tableView.scrollEnabled = false
        
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
        
        //Swipe Gesture Up für TableView
        var swipeUpTableViewGesture = UISwipeGestureRecognizer(target: self, action: "swipeInTableView:")
        swipeUpTableViewGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUpTableViewGesture)

        //Swipe Gesture Down für TableView
        var swipeDownTableViewGesture = UISwipeGestureRecognizer(target: self, action: "swipeInTableView:")
        swipeDownTableViewGesture.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownTableViewGesture)

        //Swipe Gesture Down für Map
        var swipeDownMap = UISwipeGestureRecognizer(target: self, action: "swipeDownInMap")
        swipeDownMap.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDownMap)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showShareYourLocationVCSegue" {
            var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
            
            shareLocationVC.location = self.locationToShare!
        }
        if segue.identifier == "showFriendsVCSegue" {
            var shareLocationVC:ShareLocationVC = segue.destinationViewController as ShareLocationVC
            
            shareLocationVC.location = self.locationToShare!
        }
    }
    
    // MARK: - Button Handling
    
    func locateMeButtonPressed() {
        mapVC.zoomIn()
    }
    
    func myLocationButtonPressed() {
        var longitude = 47.35 as Double
        var latitude = 8.68333 as Double
        if let location = mapVC.mapView.userLocation?.location{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
                locationToShare = LocationStore.defaultStore().createLocation("TestName", timestamp: nil, longitude: longitude, latitude: latitude, user: nil)
                
                var shareLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("shareLocationVC") as ShareLocationVC
                shareLocationVC.location = locationToShare
                self.navigationController?.pushViewController(shareLocationVC, animated: true)
    }
    
    func shareYourLocationButtonPressed(){

        
        // Zwischen den TableViews switchen
        self.tableViewIsExtended = !self.tableViewIsExtended
    }
    
    func contactButtonPressed() {
        var addFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addFriendsVC") as AddFriendsVC
        self.navigationController?.pushViewController(addFriendsVC, animated: true)
        
    }

    func swipeInTableView(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Up:
                if !tableViewIsExtended{
                    // tableView ausklappen
                    self.animateViewToTop()
                }
            case UISwipeGestureRecognizerDirection.Down:
                println("ContentOffset of TableView: \(self.tableVC.tableView.contentOffset.y)")
                if (tableViewIsExtended && self.tableVC.tableView.contentOffset.y == 0){
                    // tableView einklappen
                    println("Table View einklappen von TC")
                }
            default:
                break
            }
        }
    }
    
    func swipeDownInMap(){
        if tableViewIsExtended{
            // tableView einklappen
            self.animateViewToBottom()
        }
    }
    
    func animateViewToTop(){
        self.tableViewIsExtended =  true

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * 55 - self.tableViewHeight
            
            let topSpace = 100 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            self.shareYourLocationButton.backgroundColor = UIColor.RedColor()
            self.view.frame = CGRectMake(0, -transitionConstant, self.view.frame.width, self.view.frame.height+2*transitionConstant)
            self.tableVC.view.frame = CGRectMake(0, 0, self.view.frame.width, transitionConstant+self.tableViewHeight)
            self.tableVC.tableView.frame = self.tableVC.view.frame
        })
    }
    
    func animateViewToBottom(){
        self.tableViewIsExtended = false

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            let numberOfRows = CGFloat(self.tableVC.tableView.numberOfRowsInSection(0))
            var transitionConstant = numberOfRows * 55 - self.tableViewHeight
            
            let topSpace = 100 as CGFloat
            let maxTransition = self.view.frame.height-self.tableViewHeight-topSpace
            transitionConstant = transitionConstant > maxTransition ? maxTransition : transitionConstant
            self.shareYourLocationButton.backgroundColor = UIColor.RedColor()
            self.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-2*transitionConstant)
            self.tableVC.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.tableViewHeight)
        })
    }
}


