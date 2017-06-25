//
//  UIViewController + Navigation.swift
//  Loci
//
//  Created by Bastian Morath on 23/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

var mainScreenVC: MainScreenVC!
var addedController: UIViewController!

extension MainScreenVC{
    func addViewController(_ controller: UIViewController){
        mainScreenVC = self
        addedController = controller
        
        self.mapVC.mapView.isScrollEnabled = false
        self.mapIsAtBottom = true
        self.mapVC.mapIsAtBottom = true
        self.addChildViewController(controller)
        self.container.insertSubview(controller.view, at: 0)
        
        // Den Button neu positionieren, damit er nicht mit der Map animiert wird
        if controller.isKind(of: AddFriendsVC.self){
            self.addFriendsButton.removeFromSuperview()
            let window = UIApplication.shared.keyWindow
            window!.addSubview(self.addFriendsButton)
            self.addFriendsButton.positionToView(window!, location: self.addFriendsButton.buttonLocation!)
        }
        // TODO:- Grünen Controller auch hinzufügen
        if controller.isKind(of: FavoritePlacesVC.self){
            self.favoritePlacesButton.removeFromSuperview()
            let window = UIApplication.shared.keyWindow
            window!.addSubview(self.favoritePlacesButton)
            self.favoritePlacesButton.positionToView(window!, location: self.favoritePlacesButton.buttonLocation!)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            let translation = CGAffineTransform(translationX: 0, y: Constants.screenHeight-Constants.mapHeight)
            
            self.homeViewContainer.transform = translation
            }, completion: { (Bool) -> Void in
                if controller.isKind(of: AddFriendsVC.self){
                    self.addFriendsButton.isHidden = true
                    self.favoritePlacesButton.isUserInteractionEnabled = false
                }
                if controller.isKind(of: FavoritePlacesVC.self){
                    self.favoritePlacesButton.isHidden = true
                    self.addFriendsButton.isUserInteractionEnabled = false
                }
        })
        controller.didMove(toParentViewController: self)
    }
}


extension UIViewController{
    func dismissViewController(){
        mainScreenVC.mapVC.mapView.isScrollEnabled = true
        
        mainScreenVC.addFriendsButton.isHidden = false
        mainScreenVC.favoritePlacesButton.isHidden = false
        
        mainScreenVC.friendsTableVC.reloadData()
        mainScreenVC.sharedLocationsTableVC.reloadData()
        
        // Den Button temporär während der Animation auf dem keyWindow positionieren, damit er nicht mit der Map animiert wird
        if addedController.isKind(of: AddFriendsVC.self){
            mainScreenVC.addFriendsButton.removeFromSuperview()
            let window = UIApplication.shared.keyWindow
            window!.addSubview(mainScreenVC.addFriendsButton)
            mainScreenVC.addFriendsButton.positionToView(window!, location: mainScreenVC.addFriendsButton.buttonLocation!)
        }
        
        if addedController.isKind(of: FavoritePlacesVC.self){
            mainScreenVC.favoritePlacesButton.removeFromSuperview()
            let window = UIApplication.shared.keyWindow
            window!.addSubview(mainScreenVC.favoritePlacesButton)
            mainScreenVC.favoritePlacesButton.positionToView(window!, location: mainScreenVC.favoritePlacesButton.buttonLocation!)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            let translation = CGAffineTransform(translationX: 0, y: 0)
            
            mainScreenVC.homeViewContainer.transform = translation
            
            }, completion: { (Bool) -> Void in
                self.willMove(toParentViewController: nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
                
                // Den Buttonn wieder dem MainScreeenVC hinzufügen
                if addedController.isKind(of: AddFriendsVC.self){
                    mainScreenVC.addFriendsButton.removeFromSuperview()
                    mainScreenVC.homeViewContainer.addSubview(mainScreenVC.addFriendsButton)
                    mainScreenVC.addFriendsButton.positionButtonToLocation(.topRight)
                    mainScreenVC.favoritePlacesButton.isUserInteractionEnabled = true

                }
                if addedController.isKind(of: FavoritePlacesVC.self){
                    mainScreenVC.favoritePlacesButton.removeFromSuperview()
                    mainScreenVC.homeViewContainer.addSubview(mainScreenVC.favoritePlacesButton)
                    mainScreenVC.favoritePlacesButton.positionButtonToLocation(.topLeft)
                    mainScreenVC.addFriendsButton.isUserInteractionEnabled = true
                }
                
                mainScreenVC.mapIsAtBottom = false
                mainScreenVC.mapVC.mapIsAtBottom = false
        })
    }
}
