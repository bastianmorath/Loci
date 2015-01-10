//
//  ViewController.swift
//  AStalker
//
//  Created by Lukas Reichart on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit
import AddressBook
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let contacts = LocationStore.defaultStore().getContacts()
    if let contactArray = contacts{
        for person in contacts! {
            let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as String
            let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty)?.takeRetainedValue() as? String
            let number = ABRecordCopyValue(person, kABPersonPhoneProperty)?.takeRetainedValue() as? String
            if lastName == nil{
                println(firstName+" NILNILNIL")
                continue
            } else {
                println(firstName + lastName!)

            }
        }
    } else {
        println("Keine Kontakte...")
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

