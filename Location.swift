//
//  Loci.swift
//  Loci
//
//  Created by Bastian Morath on 16/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class Location: NSManagedObject {
    
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var name: String
    @NSManaged var timestamp: NSDate
    @NSManaged var sharedUsers: NSSet
    @NSManaged var creator: User
    
    
    func getStreet() -> String {
        var street = "Test-Strasse"
        // Strasse
//        var location = CLLocation(latitude: self.latitude.doubleValue, longitude: self.longitude.doubleValue)
//        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//            if placemarks.count > 0 {
//                let pm = placemarks[0] as CLPlacemark
//                street = pm.addressDictionary["Street"] as String
//            } })
        return street
    }
    
    func getCity() -> String {
        var city = "Test-City"
        // City
//        var location = CLLocation(latitude: self.latitude.doubleValue, longitude: self.longitude.doubleValue)
//        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//            if placemarks.count > 0 {
//                let pm = placemarks[0] as CLPlacemark
//                city = pm.addressDictionary["City"] as String
//            } })
        return city
    }
    
    func getTimeFormatted() -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.stringFromDate(NSDate())
    }
    
    func getDateFormatted() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = "dd. MMMM"
        return dateFormatter.stringFromDate(NSDate())
    }
}
