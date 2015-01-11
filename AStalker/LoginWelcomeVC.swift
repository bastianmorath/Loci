//
//  LoginWelcomeVCViewController.swift
//  AStalker
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class LoginWelcomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var pleaseEnterInfoLabel: UILabel!
    @IBOutlet var textField: ATTextField!
    @IBOutlet var forMoreInfoLabel: UILabel!
    
    var phoneNumber:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // setup labels and textField
        self.welcomeLabel.font = UIFont.ATTableViewFont()
        self.pleaseEnterInfoLabel.font = UIFont.ATFont()
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.textColor = UIColor.blackColor()
        self.textField.text = ""
        self.forMoreInfoLabel.font = UIFont.ATFont()
        
        textField.delegate = self
        
    }

    
    @IBAction func donePressed(sender: AnyObject) {
        println("done")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var stringNumber = textField.text
        phoneNumber = stringNumber.toInt()
        println("PhoneNumber: \(phoneNumber)")

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
