//
//  ViewController.swift
//  AStalker
//
//  Created by Lukas Reichart on 10/01/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let contacts = LocationStore.defaultStore().getContacts()
    if let contactArray = contacts{
        for person in contacts! {
            println(person)
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

