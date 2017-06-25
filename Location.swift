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
    
    // TODO:- Problem: reverseGeocodeLocation is asynchros --> street wird zurückgegeben, bevor der Completionhandler überhaupt aufgerufen wird
    func getStreet() -> String {
        var street = "Teststrasse"
        // Strasse
        let location = CLLocation(latitude: self.latitude.doubleValue, longitude: self.longitude.doubleValue)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if let error = error {print("reverse geodcode fail: \(error.localizedDescription)")}
            if let playcemarks = placemarks {
                if  placemarks!.count > 0 {
                    let pm = placemarks![0] 
                    let streetString = pm.thoroughfare
                    if let streetString = streetString{
                        street = streetString
                    }
                }
            }
            
        })
        
        return street
    }
    
    func getCity() -> String {
        var city = "Greifensee"
        // City
        let location = CLLocation(latitude: self.latitude.doubleValue, longitude: self.longitude.doubleValue)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if placemarks != nil && placemarks!.count > 0 {
                let pm = placemarks![0] as? CLPlacemark
                let cityString = pm?.locality
                if let cityString = cityString{
                    city = cityString
                }
            } })
        return city
    }
    
    func getCountry() -> String {
        var country = "Schweiz"
        //Country
        let location = CLLocation(latitude: self.latitude.doubleValue, longitude: self.longitude.doubleValue)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if placemarks != nil && placemarks!.count > 0 {
                let pm = placemarks![0] as? CLPlacemark
                let countryString = pm?.country
                if let countryString = countryString{
                    country = countryString
                }
            } })
        return country
    }
    
    func getTimeFormatted() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: Date())
    }
    
    func getDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "dd. MMMM"
        return dateFormatter.string(from: Date())
    }
}
