//
//  Extensions.swift
//  TZONE
//
//  Created by lapstore on 12/3/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//
import UIKit
extension UIView {
    
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
}


    func applyShadow() {
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 4.0
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 1, height: 3)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        self.clipsToBounds = false
    }
    
    
    @IBInspectable var borderwidth : CGFloat {
        
        set(newvalue){
            
            layer.borderWidth = newvalue
            
        }
        get{
            
            return layer.borderWidth
            
        }
        
    }
    
    
    @IBInspectable var bordercolor : UIColor {
        
        
        set(newvalue){
            
            
            layer.borderColor = newvalue.cgColor
        }
        get {
            
            return UIColor.black
        }
        
        
    }
    @IBInspectable var corner : CGFloat {
        
        set(val){
            
            layer.cornerRadius = val
            
        }
        get {
            
            return layer.cornerRadius
            
        }
        
    }

}
extension UIViewController{
    func noConnectionAlertError()  {
        
        let alert = UIAlertController(title: "Error", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:nil))
        alert.view.tintColor = UIColor.red
        
        self.present(alert, animated: true, completion: nil)
        alert.view.tintColor = UIColor.red
        
    }
    
    func showError(_ errorMsg:String,_ title:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: "\(errorMsg)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated: true, completion: nil)
            alert.view.tintColor = UIColor.red
        }
        
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

