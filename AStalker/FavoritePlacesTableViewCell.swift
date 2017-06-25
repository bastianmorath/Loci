//
//  FavoritePlacesTableViewCell.swift
//  AStalker
//
//  Created by Bastian Morath on 04/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class FavoritePlacesTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var imageIconView: UIButton!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var hoursSpentLabel: UILabel!
    @IBOutlet var minutesSpentLabel:UILabel!
    
    var location: FavoriteLocation!
    
    // TableView instance
    var tableView = UITableView()
    
    // Der View des FavoritePlacesVC; Wird in der DatSource gesetzt
    var view = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.nameTextField.font = UIFont.ATTableViewFont()
        self.nameTextField.delegate = self
        self.addressLabel.font = UIFont.ATFont()
        self.hoursSpentLabel.font = UIFont.ATTableViewFont()
        self.minutesSpentLabel.font = UIFont.ATFont()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // TODO:- FavoriteLocation und benennen separat!
    override func configureWithModelObject(_ model: AnyObject?) {
        let location = model as! FavoriteLocation
        self.location = location
        self.hoursSpentLabel.text = "\(location.hoursSpent())h"
        self.minutesSpentLabel.text = "\(location.minutesSpent())sec"
        self.hoursSpentLabel.textColor = UIColor.black
        self.minutesSpentLabel.textColor = UIColor.GreyColor()
        if location.isFavorite{
            self.nameTextField.text = location.getName()
            self.addressLabel.text = "\(location.getStreet()), \(location.getCity())"
            self.imageIconView.imageView?.image =  self.imageIconView.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.imageIconView.imageView?.tintColor = UIColor.GreenColor()
        } else {
            self.nameTextField.text = location.getName()
            self.addressLabel.text = "\(location.getCity()), \(location.getCountry())"
            self.imageIconView.imageView?.image =  self.imageIconView.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.imageIconView.imageView?.tintColor = UIColor.GreyColor()
        }
        
        // Der momentane Ort des users wird grün angezeigt
        if location == LocationStore.defaultStore().getLocalUser()?.currentLocation {
            self.hoursSpentLabel.textColor = UIColor.GreenColor()
            self.minutesSpentLabel.textColor = UIColor.GreenColor()
        }
        
        // Das Unterwegs-TextField kann nicht bearbeitet werden
        if location == LocationStore.defaultStore().getOnTheWayLocation() {
            self.addressLabel.text = ""
            self.nameTextField.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func iconPressed(_ sender: AnyObject) {
        // Die Unterwegs-Location bleibt immer in den FavoriteLocations
        if location != LocationStore.defaultStore().getOnTheWayLocation() {
            self.location.isFavorite =  !self.location.isFavorite
        }
        
        let button = sender as! UIButton
        let indexPath = self.tableView.indexPath(for: button.superview!.superview as! UITableViewCell)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath!], with: .automatic)
        self.tableView.endUpdates()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.location.name = textField.text!
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Name speichern
        self.location.name = textField.text!
        
        // Observer löschen
        let cell = textField.superview!.superview as! UITableViewCell
        
        NotificationCenter.default.removeObserver(cell)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview!.superview as! UITableViewCell
        // Scrolle zum TextField, falls der User im TableView gescrollt hat
        let rect = textField.superview!.convert(textField.superview!.frame, to: self.tableView)
        self.tableView.scrollRectToVisible(rect, animated: true)
        NotificationCenter.default.addObserver( cell, selector: #selector(FavoritePlacesTableViewCell.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver( cell, selector: #selector(FavoritePlacesTableViewCell.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Scrolle zum TextField, falls der User im TableView gescrollt hat
        let rect = textField.superview!.convert(textField.superview!.frame, to: self.tableView)
        self.tableView.scrollRectToVisible(rect, animated: true)
        return true
    }
    
    func keyboardWillShow(_ notification: Foundation.Notification){
        // Verschiebe den ganzen View
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            // TableView frame ändern
            let keyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
            var currentFrameOfTableView = self.tableView.frame
            currentFrameOfTableView.size.height -= keyboardHeight - Constants.mapHeight
            
            UIView.animate(withDuration: duration, delay: 0.0, options: animationCurve, animations: { () -> Void in
                self.tableView.frame = currentFrameOfTableView
                }, completion:{(Bool) -> Void in
                    self.tableView.frame = currentFrameOfTableView
            })
            
        }
    }
    
    func keyboardWillHide(_ notification: Foundation.Notification)    {
        // Verschiebe den ganzen View
        if let userInfo = notification.userInfo {
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            // TableView frame ändern
            let keyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
            var currentFrameOfTableView = self.tableView.frame
            currentFrameOfTableView.size.height += keyboardHeight - Constants.mapHeight
            UIView.animate(withDuration: duration, delay: 0.0, options: animationCurve, animations: { () -> Void in
                self.tableView.frame = currentFrameOfTableView
                }, completion:{(Bool) -> Void in
                    self.tableView.frame = currentFrameOfTableView
            })
        }
    }
}
