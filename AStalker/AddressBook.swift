//
//  AddressBook.swift
//  AStalker
//
//  Created by Bastian Morath on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class AddressBook: NSObject{
    lazy var addressBook: ABAddressBookRef = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBookRef
        }()
    

    
    
    class func defaultStore() -> AddressBook {
        struct StaticInstance {
            static var instance: AddressBook?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once( &StaticInstance.token ) {
            StaticInstance.instance = AddressBook()
        }
        
        return StaticInstance.instance!
    }
    

    func askForAccess(){
        
        ABAddressBookRequestAccessWithCompletion(addressBook,
            {[weak self] (granted: Bool, error: CFError!) in
                
                if granted{
                    let strongSelf = self!
                    println("Access is granted")
                    
                } else {
                    println("Access is not granted")
                }
                
        })
    }
    
    /*
    Diese Funktionen geben an, ob Zugriff auf das Adressbuch gegeben wurde
    */
    func accesAuthorized() -> Bool{
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            println("Already authorized")
            return true
        case .NotDetermined:
            self.askForAccess()
            return self.accesAuthorized()
        default:
            println("Access denied")
            let alert = UIAlertView(title: "Kein Zugriff", message: "Gehen Sie in die Einstellungen und erlauben Sie AStalker Zugriff auf IHre Kontakte", delegate: self, cancelButtonTitle: "Verstanden!")
            alert.show()

            return false
        }
    }
}

