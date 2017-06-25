//
//  FavoriteLocation.swift
//  AStalker
//
//  Created by Bastian Morath on 10/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import CoreData

class FavoriteLocation: AStalker.Location {
    
    @NSManaged var isFavorite: Bool
    @NSManaged var timeSpent: Double
    @NSManaged var name: String
    
   }

extension FavoriteLocation{
    func hoursSpent() -> Int{
        return Int(floor(timeSpent/3600))
    }
    
    //TODO:- minuen in Sekunden umwandeln -> Debugzwecke
    func minutesSpent() -> Int{
        return Int(floor((timeSpent.truncatingRemainder(dividingBy: 3600)) / 60))
    }
    
    func getName() -> String{
        if !self.name.isEmpty{
            return self.name
        } else {
            return self.getStreet()
        }
    }

}
