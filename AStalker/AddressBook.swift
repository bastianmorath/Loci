
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
    private static var __once: () = {
            StaticInstance.instance = AddressBook()
        }()
    lazy var addressBook: ABAddressBook = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue() as ABAddressBook
        }()
    
    
    
    
    class func defaultStore() -> AddressBook {
        struct StaticInstance {
            static var instance: AddressBook?
            static var token: Int = 0
        }
        
        _ = AddressBook.__once
        
        return StaticInstance.instance!
    }
    
    
    func askForAccess(){
        
        ABAddressBookRequestAccessWithCompletion(addressBook,
            {[weak self] (granted: Bool, error: CFError!) in
                
                if granted{
                    let strongSelf = self!
                    print("Access is granted")
                    
                } else {
                    print("Access is not granted")
                }
                
        })
    }
    
    /*
    Diese Funktionen geben an, ob Zugriff auf das Adressbuch gegeben wurde
    */
    func accesAuthorized() -> Bool{
        switch ABAddressBookGetAuthorizationStatus(){
        case .authorized:
            print("Already authorized")
            return true
        case .notDetermined:
            self.askForAccess()
            return self.accesAuthorized()
        default:
            print("Access denied")
            let alert = UIAlertView(title: "Kein Zugriff", message: "Gehen Sie in die Einstellungen und erlauben Sie Loci Zugriff auf IHre Kontakte", delegate: self, cancelButtonTitle: "Verstanden!")
            alert.show()
            
            return false
        }
    }
    
    /**
    Diese Methode gibt ein Array zurück. Dieser enthält pro Kontakt ein Dictionary mit den Daten des Kontaktes. Welche Properties im Dictionary gespeichert werden sollen, kann über die Boolsche Variabeln dieser Methode bestummen werden.
    
    :returns: Ein Array mit Dictionaries
    */
    func getContacts(_ addName: Bool = false, addPhoneNumber: Bool = false) -> [Dictionary<String, AnyObject>]?{
        
        if self.accesAuthorized() {
            let addressBook: ABAddressBook = AddressBook.defaultStore().addressBook as ABAddressBook
            let allPeople = ABAddressBookCopyArrayOfAllPeople(
                addressBook).takeRetainedValue() as NSArray
            var dictArray:[Dictionary<String, AnyObject>] = []
            
            for person in allPeople{
                
                var personDictionary = Dictionary<String, AnyObject>()
                if addPhoneNumber{
                    let phoneNumbers = self.getMobileNumberFromABRecordRef(person as ABRecord)
                    //Wenn der KOntakt kein Nummern gespeichert hat, überspringe diesen Kontakt
                    if let numbers = phoneNumbers {
                        personDictionary.updateValue(numbers as AnyObject, forKey: "user_identifier")
                        
                        if addName{
                            
                            var firstName = ABRecordCopyValue(person as ABRecord,
                                kABPersonFirstNameProperty).takeRetainedValue() as! String
                            let lastName = ABRecordCopyValue(person as ABRecord,
                                kABPersonLastNameProperty)?.takeRetainedValue() as? String
                            if let name = lastName {
                                firstName = firstName + " " + name
                            }
                            
                            personDictionary.updateValue(firstName as AnyObject, forKey: "name")
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
    
    func getMobileNumberFromABRecordRef(_ ref: ABRecord) -> [String]?{
        var numberArray:[String] = []
        let phoneNumbers: ABMultiValue? = ABRecordCopyValue(ref,
            kABPersonPhoneProperty)?.takeRetainedValue()
        if let phoneNumbers: ABMultiValue = phoneNumbers {
            let count: Int = ABMultiValueGetCount(phoneNumbers)
            if count>0 {
                for i in 0..<count {
                    let value = ABMultiValueCopyValueAtIndex( phoneNumbers, i )!.takeRetainedValue() as AnyObject as! String
                    numberArray.append(value)
                }
                return numberArray
            }
        }
        
        return nil
    }
    
    
    
}

