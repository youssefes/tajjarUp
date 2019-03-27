//
//  SettingsVC.swift
//  TZONE
//
//  Created by lapstore on 12/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//
import UIKit
import iOSDropDown

class SettingsVC: UIViewController {
    
    @IBOutlet weak var SaveChanges: UIButton!
    @IBOutlet weak var ViewContainFields: UIView!
    @IBOutlet weak var language: DropDown!
    @IBOutlet weak var country: DropDown!
    
    
    @IBOutlet weak var currency: DropDown!
    var countries: [String] = []
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"] // List of currencies
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
            
        }
        currency.optionArray = currencyArray
        currency.didSelect{(selectedText , index ,id) in
            
            print(index)
            print(id)
            print(selectedText)
            //            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            
        }
        
        
        // Do any additional setup after loading the view.
        self.ViewContainFields.applyShadow()
        
        language.optionArray = ["enaglish","arabic"]
        //Its Id Values and its optional
        
        // The the Closure returns Selected Index and String
        
        country.didSelect{(selectedText , index ,id) in
            
            print(index)
            print(id)
            print(selectedText)
            //            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            
        }
        country.optionArray = countries
        //Its Id Values and its optional
        
        // The the Closure returns Selected Index and String
        
        country.didSelect{(selectedText , index ,id) in
            
            print(selectedText)
            //            self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
            
        }
        
        
    }
    
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
