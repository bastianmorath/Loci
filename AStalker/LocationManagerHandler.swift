//
//  CLLocationManagerDelegate.swift
//  AStalker
//
//  Created by Bastian Morath on 10/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import MapKit

class LocationManagerHandler: NSObject, CLLocationManagerDelegate {
    /// Radius einer Location
    let kSizeOfLocation = 40 as Double
    /// Gibt an, wie lange man an einem Ort verbringen muss, damit die Location zu FavoriteLocations hinzugefügt werden soll (in Sekunden)
    let kTimeInterval = 10 as Double
    
    var currentLocation: CLLocation?
    /// Timestamp, wo der User das letzte Mal an einem anderen ort war
    var currentTimestamp: Date!
    /// Dieser Timestamp wird in jedem Aufruf dieser Methode neu gesetzt. Sie erhöht die property 'timeSpent' der currentLcoation'
    var timestampForCurrentLocation: Date!
    
    override init(){
        super.init()
    }
    
    func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations[0] as! CLLocation
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
      
        if let currentLocation = self.currentLocation {
            // Wenn der User an einer Location ist, wo schon hinzugefügt wurde, dann update die 'timeSpent'-Property, sonst update  unterwegs.timeSpent
            let tuple = self.locationExist(location)
            if self.locationExist(location).0{
                tuple.1?.timeSpent += -timestampForCurrentLocation.timeIntervalSince(Date())
                timestampForCurrentLocation = Date()
                LocationStore.defaultStore().getLocalUser()?.currentLocation = tuple.1!
            }
            
            // Wenn die Location sich nicht ändert, update timeSpent. Wenn sie sich ändert, dann ersetze die currentLocation und überprüfe timestamps
            if !locationIsNearCurrentLocation(location){
                // Timestamps vergleichen: Ist die Zeitdifferenz von currentTimestamp und jetzt grösser als kTimeInterval, dann füge die currentLocation zu den FavoriteLocations hinzu, sonst füge sie der "Unterwegs"-Location hinzu
                let timeInterval = self.getTimeIntervalBetweenCurrentTimeStampAndNow()
                if timeInterval < kTimeInterval{
                    let onTheWayLocation = LocationStore.defaultStore().getOnTheWayLocation()
                    onTheWayLocation.timeSpent += timeInterval
                    // Setze die momentane Location des LocalUsers als "Unterwegs"
                    LocationStore.defaultStore().getLocalUser()?.currentLocation = onTheWayLocation
                } else {
                    // Prüfen, ob das LocationObject schon vorhanden ist. Wenn nicht, ein neue FavoriteLocation erstellen, wen ja, mache nichts (timeSpent ist schon am Anfang der Methode erhöht worden!
                    if tuple.0{
                        // Setze die momentane Location des LocalUsers als den momentanen Ort ( Ort schon vorhanden)
                        LocationStore.defaultStore().getLocalUser()?.currentLocation = tuple.1!
                    }else { // Neue Location erstellen
                        let newFavoriteLocation = LocationStore.defaultStore().createFavoriteLocation(name: nil, longitude: longitude, latitude: latitude)
                        newFavoriteLocation!.timeSpent += timeInterval
                         self.newPlaceAdded()

                        // Setze die momentane Location des LocalUsers als den momentanen Ort ( neu erstellter Ort)
                        LocationStore.defaultStore().getLocalUser()?.currentLocation = newFavoriteLocation!
                    }
                }
                //CurrentLocation und timestamp updaten
                self.currentTimestamp = Date()
                self.currentLocation = location
                
            }
        } else {
            self.currentLocation = location
            self.currentTimestamp = Date()
            self.timestampForCurrentLocation = Date()
            
            return
        }
        
        
    }
    
    func locationIsNearCurrentLocation(_ location: CLLocation) -> Bool{
        if currentLocation!.distance(from: location) < kSizeOfLocation {
            return true
        } else {
            return false
        }
    }
    
    func getTimeIntervalBetweenCurrentTimeStampAndNow() -> TimeInterval{
        return -currentTimestamp.timeIntervalSince(Date())
    }
    
    
    func locationExist(_ location: CLLocation) -> (Bool, FavoriteLocation?){
        let favoriteLocationsArray = LocationStore.defaultStore().getFavoriteLocationsFC().fetchedObjects as! [FavoriteLocation]
        for favoriteLocation in favoriteLocationsArray{
            // Location vorhanden ->timespent erhöhen
            var favoriteLocationObject = CLLocation(latitude: Double(favoriteLocation.latitude), longitude: Double(favoriteLocation.longitude))
            if location.distance(from: favoriteLocationObject) < kSizeOfLocation{
                return (true, favoriteLocation)
            }
        }
        return (false, nil)
    }
    
    // Send notification
    func newPlaceAdded(){
        let notification = UILocalNotification()
        notification.category = "Favorite Place added"
        notification.alertBody = "You added a new Favorite Location!"
        notification.fireDate = Date()
        UIApplication.shared.scheduleLocalNotification(notification)
        
    }
    
    func reloadData(){

    }
}



