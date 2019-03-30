//
//  SettingsVC.swift
//  TZONE
//
//  Created by lapstore on 12/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//
import UIKit
import iOSDropDown

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var currencyDone: UIButton!
    
    @IBOutlet weak var countryDone: UIButton!
    @IBOutlet weak var langDone: UIButton!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBAction func hidenLangBtn(_ sender: Any) {
       self.langDone.isHidden = true
        self.pickerLangouge.isHidden = true
        
    }
    
    @IBAction func hidencurrentBtn(_ sender: Any) {
       
        self.currencyDone.isHidden = true
        self.pickerCurrency.isHidden = true
    }
    @IBAction func hiddenCountryBtn(_ sender: Any) {
        
        self.countryDone.isHidden = true
        self.pickerCountry.isHidden = true
    }
    @IBOutlet weak var pickerCountry: UIPickerView!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    @IBOutlet weak var SaveChanges: UIButton!
    @IBOutlet weak var ViewContainFields: UIView!
  
    @IBOutlet weak var pickerLangouge: UIPickerView!
    
    @IBOutlet weak var btnCuntry: UIButton!
    @IBOutlet weak var Btncurrency: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    
    var countries: [String] = ["Egypt", "Londone", "parice"]
    var lang = ["العربية","English"]
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"] // List of currencies
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerLangouge.dataSource = self
        pickerLangouge.delegate = self
        pickerCurrency.delegate = self
        pickerCurrency.dataSource = self
        pickerCountry.delegate = self
        pickerCountry.dataSource = self
        
        pickerCountry.setValue(UIColor.white, forKeyPath: "textColor")
        pickerCurrency.setValue(UIColor.white, forKeyPath: "textColor")
        pickerLangouge.setValue(UIColor.white, forKeyPath: "textColor")
        pickerLangouge.layer.cornerRadius = 10
        pickerCurrency.layer.cornerRadius = 10
        pickerCountry.layer.cornerRadius = 10
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
            
        }
       
        // Do any additional setup after loading the view.
        self.ViewContainFields.applyShadow()
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerLangouge{
            return lang.count
        }
        else if pickerView == pickerCountry {
             return countries.count
        }else{
            return currencyArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerLangouge{
            btnLanguage.setTitle(lang[row], for: .normal)
        }
        else if pickerView == pickerCountry {
           btnCuntry.setTitle(countries[row], for: .normal)
        }else{
             Btncurrency.setTitle(currencyArray[row], for: .normal)
        }
        
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func currencyAction(_ sender: Any) {
        self.currencyDone.isHidden = false
        Btncurrency.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnCuntry.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnLanguage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pickerLangouge.isHidden = true
        pickerCountry.isHidden = true
        pickerCurrency.isHidden = false
    }
    
    @IBAction func cuntryAction(_ sender: Any) {
        self.countryDone.isHidden = false
        
        Btncurrency.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnCuntry.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        btnLanguage.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pickerLangouge.isHidden = true
        pickerCountry.isHidden = false
        pickerCurrency.isHidden = true
    }
    
    @IBAction func languageAction(_ sender: Any) {
        self.langDone.isHidden = false
        Btncurrency.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnCuntry.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnLanguage.tintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        pickerLangouge.isHidden = false
        pickerCountry.isHidden = true
        pickerCurrency.isHidden = true
    }
    
}
