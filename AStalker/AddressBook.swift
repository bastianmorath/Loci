//
//  AddressBook.swift
//  Loci
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
            let alert = UIAlertView(title: "Kein Zugriff", message: "Gehen Sie in die Einstellungen und erlauben Sie Loci Zugriff auf IHre Kontakte", delegate: self, cancelButtonTitle: "Verstanden!")
            alert.show()
            
            return false
        }
    }
    
    /**
    Diese Methode gibt ein Array zurück. Dieser enthält pro Kontakt ein Dictionary mit den Daten des Kontaktes. Welche Properties im Dictionary gespeichert werden sollen, kann über die Boolsche Variabeln dieser Methode bestummen werden.
    
    :returns: Ein Array mit Dictionaries
    */
    func getContacts(addName: Bool = false, addPhoneNumber: Bool = false) -> [Dictionary<String, AnyObject>]?{
        
        if self.accesAuthorized() {
            let addressBook: ABAddressBookRef = AddressBook.defaultStore().addressBook as ABAddressBookRef
            let allPeople = ABAddressBookCopyArrayOfAllPeople(
                addressBook).takeRetainedValue() as NSArray
            var dictArray:[Dictionary<String, AnyObject>] = []
            
            for person in allPeople{
                
                var personDictionary = Dictionary<String, AnyObject>()
                if addPhoneNumber{
                    let phoneNumbers = self.getMobileNumberFromABRecordRef(person)
                    //Wenn der KOntakt kein Nummern gespeichert hat, überspringe diesen Kontakt
                    if let numbers = phoneNumbers {
                        personDictionary.updateValue(numbers, forKey: "user_identifier")
                        
                        if addName{
                            
                            var firstName = ABRecordCopyValue(person,
                                kABPersonFirstNameProperty).takeRetainedValue() as String
                            let lastName = ABRecordCopyValue(person,
                                kABPersonLastNameProperty)?.takeRetainedValue() as? String
                            if let name = lastName {
                                firstName = firstName + " " + name
                            }
                            
                            personDictionary.updateValue(firstName, forKey: "name")
                        }
                    }
                }
                dictArray.append(personDictionary)
            }
            return dictArray
        } else {
            return nil
        }
    }
    
    func getMobileNumberFromABRecordRef(ref: ABRecordRef) -> [String]?{
        var numberArray:[String] = []
        var phoneNumbers: ABMultiValueRef? = ABRecordCopyValue(ref,
            kABPersonPhoneProperty)?.takeRetainedValue()
        if let phoneNumbers: ABMultiValueRef = phoneNumbers {
            let count: Int = ABMultiValueGetCount(phoneNumbers)
            if count>0 {
                for i in 0..<count {
                    let value = ABMultiValueCopyValueAtIndex( phoneNumbers, i )!.takeRetainedValue() as AnyObject as String
                    numberArray.append(value)
                }
                return numberArray
            }
        }
        
        return nil
    }
    
    
    
}

