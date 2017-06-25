//
//  ContainerViewController.swift
//  Loci
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


//TODO: - Wenn zwischen den TableViewController gewechselt wird, muss die Höhe des Containers/Views der Höhe des TableViews angepasst werden
import Foundation
import UIKit


// Protocol, um vom TableVC die Nachricht zu bekommen, wenn eine cell gedrückt wurde
protocol TableViewAndMapDelegate {
    func animateViewToBottom()
    func didSelectAnnotationPin(_ location: Location)
    
}
class MainScreenVC: UIViewController, UIScrollViewDelegate, TableViewAndMapDelegate {
    //MARK:- Views
    // child controllers
    var mapVC: MainScreenMapVC!
    
    //TODO:- Man kann nicht den ganzen TableView scrollen...
    /// Der aktive ViewController (sharedLocationsTableVC oder friendsTableVC)
    var activeTableViewController: LIViewController! {
        willSet{
            // Frames so setzen, dass sie nebeneinander sind und nach links, resp. rechts animiert werden
            
            if newValue.isKind(of: SharedLocationsTableVC.self){
                self.sharedLocationsTableVC.view.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(sharedLocationsTableVC))
                self.sharedLocationsTableVC.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(sharedLocationsTableVC))
                
                self.friendsTableVC.view.frame = CGRect(x: Constants.screenWidth, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(self.friendsTableVC))
                self.friendsTableVC.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(self.friendsTableVC))
            } else {
                self.sharedLocationsTableVC.view.frame = CGRect(x: -Constants.screenWidth, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(sharedLocationsTableVC))
                self.sharedLocationsTableVC.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(sharedLocationsTableVC))
                
                self.friendsTableVC.view.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(self.friendsTableVC))
                self.friendsTableVC.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: self.getHeightForTableViewController(self.friendsTableVC))
            }
        }
    }
    
    
    /// TableViewController that isn't showed at the moment
    var passiveTableViewController: LIViewController{
        if self.activeTableViewController.isKind(of: SharedLocationsTableVC.self){
            return self.friendsTableVC
        } else {
            return self.sharedLocationsTableVC
        }
    }
    
    
    var sharedLocationsTableVC: SharedLocationsTableVC!
    var friendsTableVC: FriendsTableVC!
    
    
    /// Container to hold all Controllers -> For Animations
    var container: UIView!
    
    /// Container to hold Map and TableViews
    var homeViewContainer: UIView!
    
    // Containers to hold the child controllers view
    var mapContainer: UIView!
    var tableViewContainer: UIView!
    
    
    
    // MARK:-Buttons
    
    //Zeigt alle Kontakte des Users an, insbesondere wo diese sich befinden und wann sie dort waren
    var addFriendsButton: LociButton!
    
    ///
    var changeTableViewButton: LociButton!
    
    /// Zeigt die Favoriten/Meist besuchten Locations vom Nutzer an. Dort sieht man auch, wie lange man an einer Location war.
    var favoritePlacesButton: LociButton!
    
    /// Die momentane Location des Users wird auf der Karte angezeigt
    var zoomToCurrentLocationButton: LociButton!
    
    
    // MARK: - Properies und Variabeln
    
    //Wenn ein anderer Controller angezeigt wird und die Map an den Bottom animiert wird, wird die Variable auf true gesetzt
    var mapIsAtBottom = false
    
    // Gibt an, ob der TableView ausgeklappt ist oder nicht.
    var tableViewIsExtended:Bool = false {
        willSet{
            if newValue == true {
                self.mapVC.mapView.isUserInteractionEnabled = false
                self.activeTableViewController.tableView.isScrollEnabled = true
                self.activeTableViewController.tableView.isUserInteractionEnabled = true
            } else {
                self.mapVC.mapView.isUserInteractionEnabled = true
                self.activeTableViewController.tableView.isScrollEnabled = false
                self.activeTableViewController.tableView.isUserInteractionEnabled = false
            }
        }
    }
    
    
    
    //MARK:- Methoden
    override func viewDidLoad() {
        super.viewDidLoad()
        self.container = UIView(frame: self.view.frame)
        self.view.addSubview(self.container)
        self.homeViewContainer = UIView(frame: self.view.frame)
        self.homeViewContainer.backgroundColor = UIColor.WhiteColor()
        self.container.addSubview(self.homeViewContainer)
        
        // Setup MapVC
        self.mapVC = MainScreenMapVC()
        self.mapVC.delegate = self
        self.addChildViewController(mapVC)
        var mapHeight = Constants.screenWidth * Constants.kAspectRatioMapToTableView
        self.mapContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: mapHeight))
        self.homeViewContainer.addSubview(self.mapContainer)
        self.mapContainer.addSubview(self.mapVC.view)
        self.mapVC.didMove(toParentViewController: self)
        
        
        //  Setup TableViewControllers
        self.sharedLocationsTableVC = SharedLocationsTableVC()
        self.sharedLocationsTableVC.delegate = self
        self.addChildViewController(self.sharedLocationsTableVC)
        
        self.friendsTableVC = FriendsTableVC()
        self.friendsTableVC.delegate = self
        self.addChildViewController(self.friendsTableVC)
        
        self.tableViewContainer = UIView(frame: CGRect(x: 0, y: Constants.screenHeight-Constants.tableViewHeight, width: Constants.screenWidth, height: Constants.tableViewHeight))
        tableViewContainer.addSubview(self.sharedLocationsTableVC.view)
        tableViewContainer.addSubview(self.friendsTableVC.view)
        
        self.homeViewContainer.addSubview(self.tableViewContainer)
        
        sharedLocationsTableVC.didMove(toParentViewController: self)
        friendsTableVC.didMove(toParentViewController: self)
        
        
        // Set default TableViewController
        self.activeTableViewController = self.friendsTableVC
        
        self.tableViewIsExtended = false
        
        // Setup Buttons
        favoritePlacesButton = LociButton(type: .multipleLocations, color: .white)
        favoritePlacesButton.addTarget(self, action: #selector(MainScreenVC.favoritePlacesButtonPressed), for: UIControlEvents.touchUpInside)
        self.homeViewContainer.addSubview(favoritePlacesButton)
        favoritePlacesButton.positionButtonToLocation(.topLeft)
        
        addFriendsButton = LociButton(type:.contact, color: .white)
        addFriendsButton.addTarget(self, action: #selector(MainScreenVC.addFriendsButtonPressed), for: UIControlEvents.touchUpInside)
        self.homeViewContainer.addSubview(addFriendsButton)
        addFriendsButton.positionButtonToLocation(.topRight)
        
        changeTableViewButton = LociButton(type:.contactLocation, color: .grey)
        changeTableViewButton.addTarget(self, action: #selector(MainScreenVC.changeTableViewButtonPressed), for: UIControlEvents.touchUpInside)
        self.homeViewContainer.addSubview(changeTableViewButton)
        changeTableViewButton.positionButtonToLocation(.topHalfLeft)
        
        zoomToCurrentLocationButton = LociButton(type:.singleLocation, color: .white)
        zoomToCurrentLocationButton.addTarget(self, action: #selector(MainScreenVC.zoomToCurrentLocationButtonPressed), for: UIControlEvents.touchUpInside)
        self.mapContainer.addSubview(zoomToCurrentLocationButton)
        zoomToCurrentLocationButton.positionButtonToLocation(.bottomRight)
        
        //Swipe Gesture Up
        var swipeUpTableViewGesture = UISwipeGestureRecognizer(target: self, action: #selector(MainScreenVC.swipeUp))
        swipeUpTableViewGesture.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUpTableViewGesture)
        
        
        //Swipe Gesture Down
        var swipeDownMap = UISwipeGestureRecognizer(target: self, action: #selector(MainScreenVC.swipeDown))
        swipeDownMap.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDownMap)
    }
    
    // MARK: - Button Handling
    
    func zoomToCurrentLocationButtonPressed() {
        mapVC.mapView.zoomIn()
    }
    
    func favoritePlacesButtonPressed() {
        if !self.tableViewIsExtended{
            var favoritePlacesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "favoritePlacesVC") as! FavoritePlacesVC
            self.addViewController(favoritePlacesVC)
        }
    }
    
    // TODO:- Wenn gewechselt wird, überprüfen, ob der neue TableView gerade so gross wird, wie wenn er zugeklappt wäre -> dann zuklappen
    func changeTableViewButtonPressed(){
        // Zwischen den TableViews switchen
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            // Zuerst muss der Frame des neuen TableViewControllers gesetzt werden, da nicht beide TableViews unbedingt gleich hoch sein müssen
            if self.tableViewIsExtended{
                var heightForVC = self.getHeightForTableViewController(self.passiveTableViewController)
                
                // HomeViewContainer
                self.homeViewContainer.frame = CGRect(x: 0, y: -heightForVC + Constants.tableViewHeight, width: Constants.screenWidth, height: Constants.screenHeight + heightForVC - Constants.tableViewHeight)
                // TableViewContainer
                self.tableViewContainer.frame = CGRect(x: 0, y: self.tableViewContainer.frame.origin.y, width: Constants.screenWidth, height: heightForVC)
            }
            // Animation
            if self.activeTableViewController.isKind(of: FriendsTableVC.self){
                self.activeTableViewController = self.sharedLocationsTableVC
                self.changeTableViewButton.backgroundColor = UIColor.RedColor()
                self.changeTableViewButton.positionButtonToLocation(.topHalfRight)
            } else {
                self.activeTableViewController = self.friendsTableVC
                self.changeTableViewButton.backgroundColor = UIColor.GreyColor()
                self.changeTableViewButton.positionButtonToLocation(.topHalfLeft)
            }
            // Muss aufgerufen werden, damit der Wechsel des Buttons animiert wird
            self.changeTableViewButton.layoutIfNeeded()
        })
        
        
        //Da der activeController neu gesetzt wurde, muss die property tableViewIsExtended nochmals gesetzt werden, um auch beim neuen Controller die das Verhalten des TableViews zu bestimmen. Ist die Höhe des TableViews gerade so gross, wie wenn er nicht ausgeklappt wäre, setze die Variable auf false
        if self.activeTableViewController.tableView.contentSize.height == Constants.tableViewHeight{
            self.tableViewIsExtended = false
        }else {
            self.tableViewIsExtended = self.tableViewIsExtended as Bool
        }
        
    }
    
    func addFriendsButtonPressed() {
        if !self.tableViewIsExtended{
            var addFriendsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addFriendsVC") as! AddFriendsVC
            self.addViewController(addFriendsVC)
        }
    }
    
    
    // MARK:- Swipe-Gesture
    func swipeUp(){
        if !tableViewIsExtended && !self.mapIsAtBottom{
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
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let heightOfActiveTVC = self.getHeightForTableViewController(self.activeTableViewController)
            let heightOfPassiveTVC = self.getHeightForTableViewController(self.passiveTableViewController)
            
            if heightOfActiveTVC - Constants.tableViewHeight < 0{
                self.tableViewIsExtended = false
                return
            }
            
            // HomeContainer Frame
            self.homeViewContainer.frame = CGRect(x: 0, y: -heightOfActiveTVC + Constants.tableViewHeight, width: Constants.screenWidth, height: Constants.screenHeight + heightOfActiveTVC - Constants.tableViewHeight)
            
            // Set BOTH TableView Frames
            self.tableViewContainer.frame = CGRect(x: 0, y: self.tableViewContainer.frame.origin.y, width: Constants.screenWidth, height: heightOfActiveTVC)
            self.activeTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: heightOfActiveTVC)
            
            var x_Value_OfPassiveViewController:CGFloat!
            
            if self.passiveTableViewController.isKind(of: SharedLocationsTableVC.self){
                x_Value_OfPassiveViewController = -Constants.screenWidth
            } else {
                x_Value_OfPassiveViewController = +Constants.screenWidth
            }
            self.passiveTableViewController.tableView.frame = CGRect(x: x_Value_OfPassiveViewController, y: 0, width: Constants.screenWidth, height: heightOfPassiveTVC)
            
            self.zoomToCurrentLocationButton.alpha = 0.0
        })
    }
    
    
    func animateViewToBottom(){
        
        
        self.tableViewIsExtended = false
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            // Scroll to top of BOTH tableView
            self.activeTableViewController.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
            self.passiveTableViewController.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
            
            }, completion: { (Bool) -> Void in
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    // HomeViewContainer Frame
                    self.homeViewContainer.frame = self.view.frame
                    
                    // TableView Frames
                    self.tableViewContainer.frame = CGRect(x: 0, y: Constants.screenHeight - Constants.tableViewHeight, width: Constants.screenHeight, height: Constants.tableViewHeight)
                    self.activeTableViewController.tableView.frame = CGRect(x: 0, y: 0, width: Constants.screenWidth, height: Constants.tableViewHeight)
                    
                    self.zoomToCurrentLocationButton.alpha = 1.0
                })
        }) 
    }
    
    func didSelectAnnotationPin(_ location: Location){
        if !self.tableViewIsExtended{
            var shareLocationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shareLocationVC") as! ShareLocationVC
            shareLocationVC.location = LocationStore.defaultStore().createSharedLocation(Date(), longitude: 5.5, latitude: 3.4, user: nil)
            self.addViewController(shareLocationVC)
        }
    }
    
    func getHeightForTableViewController(_ tableViewController: LIViewController) -> CGFloat{
        // Height: Höhe des TableViews mit allen Cells (Cells + HeaderView)
        let height = tableViewController.tableView.rect(forSection: 0).maxY
        let maxHeight = Constants.screenHeight - Constants.topSpace
        
        return height > maxHeight ? maxHeight : height
    }
    
    
}


