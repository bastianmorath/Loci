//
//  LoginRegistrationVC.swift
//  Loci
//
//  Created by Florian Morath on 11.01.15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class LoginRegistrationVC: UIViewController, UITextFieldDelegate {
    
    
    //IBOutlets
    @IBOutlet var persDetailLabel: UILabel!
    @IBOutlet var pleaseFilOutLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var nameTextField: ATTextField!
    
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var passwordTextField: ATTextField!
    @IBOutlet var passwordAgainLabel: UILabel!
    
    @IBOutlet var passwordAgainTextField: ATTextField!
    
    // Eingaben des Benutzers
    var password1:Int?
    var password2:Int?
    var name:Int?
    
    @IBAction func finishPressed(_ sender: AnyObject) {
        
        if password1 != nil && password2 != nil && password1 == password2 {
            // save User with name and password
            // dismiss ViewController
        } else {
            // Try again
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // setup labels and TextField
        persDetailLabel.font = UIFont.ATTableViewFont()
        pleaseFilOutLabel.font = UIFont.ATFont()
        nameLabel.font = UIFont.ATFont()
        passwordLabel.font = UIFont.ATFont()
        passwordAgainLabel.font = UIFont.ATFont()
        
        // textField
        nameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordAgainTextField.delegate = self
        passwordAgainTextField.isSecureTextEntry = true
      
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // move view up during editing textField
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(true, moveValue: 102)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(false, moveValue: 102)
    }
    
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
