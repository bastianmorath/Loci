//
//  LoginWelcomeVCViewController.swift
//  Loci
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
        self.textField.backgroundColor = UIColor.white
        self.textField.textColor = UIColor.black
        self.textField.text = ""
        self.forMoreInfoLabel.font = UIFont.ATFont()
        self.resendCodeLabel.font = UIFont.ATFont()
        self.resendCodeLabel.isHidden = true
        
        textField.delegate = self
        
    }
    
    
    @IBAction func donePressed(_ sender: AnyObject) {
        print("done")

        if code != nil && validCode(code!) {
            // dismiss
        } else {
            self.resendCodeLabel.isHidden = false
            self.textField.text = ""
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validCode (_: Int)->(Bool) {
        
        // Überprüfen ob Code richtig
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var stringCode = textField.text
        code = stringCode.int()
        print("Code: \(code)")
        if code != nil {
            // dissmiss
            
        } else {
            self.resendCodeLabel.isHidden = false
            self.textField.text = ""
        }
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if code != nil && validCode(code!) {
            // dismiss
        } else {
            self.resendCodeLabel.isHidden = false
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
