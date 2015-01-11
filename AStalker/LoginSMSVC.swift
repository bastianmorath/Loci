//
//  LoginWelcomeVCViewController.swift
//  AStalker
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class LoginSMSVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var gotSMS: UILabel!
    @IBOutlet var pleaseEnterInfoLabel: UILabel!
    @IBOutlet var textField: ATTextField!
    @IBOutlet var forMoreInfoLabel: UILabel!
    @IBOutlet var resendCodeLabel: UILabel!
    
    var code:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // setup labels and textField
        self.gotSMS.font = UIFont.ATTableViewFont()
        self.pleaseEnterInfoLabel.font = UIFont.ATFont()
        self.textField.backgroundColor = UIColor.whiteColor()
        self.textField.textColor = UIColor.blackColor()
        self.textField.text = ""
        self.forMoreInfoLabel.font = UIFont.ATFont()
        self.resendCodeLabel.font = UIFont.ATFont()
        self.resendCodeLabel.hidden = true
        
        textField.delegate = self
        
    }
    
    
    @IBAction func donePressed(sender: AnyObject) {
        println("done")

        if code != nil && validCode(code!) {
            // dismiss
        } else {
            self.resendCodeLabel.hidden = false
            self.textField.text = ""
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validCode (Int)->(Bool) {
        
        // Überprüfen ob Code richtig
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        var stringCode = textField.text
        code = stringCode.toInt()
        println("Code: \(code)")
        if code != nil {
            // dissmiss
            
        } else {
            self.resendCodeLabel.hidden = false
            self.textField.text = ""
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if code != nil && validCode(code!) {
            // dismiss
        } else {
            self.resendCodeLabel.hidden = false
            self.textField.text = ""
        }

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
