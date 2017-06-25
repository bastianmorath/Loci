//
//  AppDelegate.swift
//  Loci
//
//  Created by Lukas Reichart on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootViewController : UIViewController?
    var locationManager: CLLocationManager?
    var locationDelegate: CLLocationManagerDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if LocationStore.defaultStore().getLocalUser() == nil {
            LocationStore.defaultStore().createDebugUsers()
            LocationStore.defaultStore().createDebugLocalUser()
            // Erstelle eine "Unterwegs"-Location
            LocationStore.defaultStore().createOnTheWayLocation()
        }
        self.rootViewController = MainScreenVC()
        
        if let window = window {
            self.window!.rootViewController = self.rootViewController
            self.window!.makeKeyAndVisible()
        }
        
        
        /*
        Ask for AddressBookAccess
        */
        
        // Setup MKMapView UserLocation Tracking
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
          self.locationDelegate = LocationManagerHandler()
        locationManager?.delegate = self.locationDelegate
        locationManager?.startUpdatingLocation()
        
        
        // Notifications
        
        let action: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        action.identifier = "Favorite Place addded"
        action.title = "Favorite Place added"
        action.activationMode = UIUserNotificationActivationMode.background
        action.isDestructive = true
        action.isAuthenticationRequired = false
        
        let category : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        category.identifier = "Favorite Place added"
        
        let defaultAction = [action]
        
        category.setActions(defaultAction, for: UIUserNotificationActionContext.default)
        
        // NSSet
        let categories = NSSet(object: category) as Set<NSObject>
        
        
        let type: UIUserNotificationType = UIUserNotificationType.alert
        let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: type, categories: categories)
        
        UIApplication.shared.registerUserNotificationSettings(settings)
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    //TODO:- Accuracy of locationManager verkleinern
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

