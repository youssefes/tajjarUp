//
//  InformationVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import TextFieldEffects

class InformationVC: UIViewController {
    var top = false
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var DoneTime: UIButton!
    
    @IBOutlet weak var DoneButton: UIButton!
    @IBOutlet weak var DateView: UIView!
    var myBookInformation = [MyBookingModel]()
    var orderIdInformation = ""
    @IBOutlet weak var PhoneNumber: HoshiTextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var SecondChang: UIButton!
    @IBOutlet weak var mrBtn: UIButton!
    @IBOutlet weak var MsBtn: UIButton!
    @IBOutlet weak var EmailAddress: HoshiTextField!
    @IBOutlet weak var LastNAme: HoshiTextField!
    @IBOutlet weak var FirstName: HoshiTextField!
    @IBOutlet weak var ContinueBooking: UIButton!
    @IBOutlet weak var ViewDriverDetails: UIView!
    @IBOutlet weak var ViewCarRental: UIView!
    
    
    @IBOutlet weak var txtSecondPl: HoshiTextField!
    @IBOutlet weak var txtFirstPl: HoshiTextField!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var DateSecond: UILabel!
    
    @IBOutlet weak var timeSecond: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker.addTarget(self, action: #selector(datePickerValueEnd), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(datePickerValue), for: .valueChanged)
        // Do any additional setup after loading the view.
        DatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.ViewDriverDetails.applyShadow()
        self.ViewDriverDetails.roundCorners(cornerRadius: 10)
        self.ViewCarRental.applyShadow()
        self.ViewCarRental.roundCorners(cornerRadius: 10)
        
        self.ContinueBooking.roundCorners(cornerRadius: 20)
        GetInfo()
    }
    
    func GetInfo() {
        if myBookInformation.count > 0{
            ContinueBooking.setTitle("show Booking Summary", for: .normal)
        }
            let url  = Globals.information
            let mem_id = DataManager().callData("ID")
            let param = "mem_id=\(mem_id)&order_id=\(self.orderIdInformation)"
            Helper.POSTStringTwo(url: url, parameters: param) { (data,statuse) in
                if statuse {
                    self.setupView(data: data)
                    
                }
            }
        }
    
    func setupView(data : [String : Any ]?){
    
        guard let json = data else{
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // your code here
                if let driver_last_name = json["Picking_Up_locations"] as? String{
                    
                    self.txtFirstPl.text = driver_last_name
                }
                if let driver_last_name = json["Droping_off_locations"] as? String{
                    self.txtSecondPl.text = driver_last_name
                }
                
                if let Picking_Up_Time = json["Picking_Up_Time"] as? String{
                    self.TimeLabel.text = Picking_Up_Time
                }
                if let Picking_Up_Date = json["Picking_Up_Date"] as? String{
                    self.DateLabel.text = Picking_Up_Date
                }
                
                if let Droping_off_Data = json["Droping_off_Date"] as? String{
                    self.DateSecond.text = Droping_off_Data
                }
                
                if let Drop_off_time = json["Droping_off_Time"] as? String{
                    self.timeSecond.text = Drop_off_time
                }
                
                if let driver_last_name = json["driver_last_name"] as? String{
                    self.LastNAme.text = driver_last_name
                }
                if let driver_first_name = json["driver_first_name"] as? String{
                    self.FirstName.text = driver_first_name
                }
                if let driver_email = json["driver_email"] as? String{
                    self.EmailAddress.text = driver_email
                }
                if let driver_mobile = json["driver_mobile"] as? String{
                    self.PhoneNumber.text = driver_mobile
                }
                
                if let type = json["type"] as? String{
                    if type == "Mr" {
                        self.mrBtn.isSelected = true
                        
                    }else{
                        self.MsBtn.isSelected = true
                    }
                }
                
                
            }
        }
        
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func datePickerValueEnd(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        
        
        var arrayData = [String]()
        
        dateFormatter.dateFormat = "EEE"
        let month = dateFormatter.string(for: sender.date)
        arrayData.append(month!)
        
        dateFormatter.dateFormat = "MMM"
        let day2 = dateFormatter.string(for: sender.date)
        arrayData.append(day2!)
        
        dateFormatter.dateFormat = "d"
        let day = dateFormatter.string(for: sender.date)
        
        arrayData.append(day!)
        if top == false {
            self.DateLabel.text = arrayData.joined(separator: ",")
        }else{
            self.DateSecond.text = arrayData.joined(separator: ",")
        }
        
        
    
    }
    
    @objc func datePickerValue(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        
            dateFormatter.dateFormat = "HH:mm a"
        if top == false{
            self.TimeLabel.text = dateFormatter.string(for: sender.date)!
        }else{
            self.timeSecond.text = dateFormatter.string(for: sender.date)!
        }
        
        }
    
        
    
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func RadioButtonOne(_ sender: Any) {
        
    }
    
    @IBAction func RadioButtoTwo(_ sender: Any) {
        
    }
    
    @IBAction func ChangeDateone(_ sender: Any) {
        
        self.DatePicker.isHidden = false
        self.timePicker.isHidden  = false
        self.DateView.isHidden = false
        self.timeView.isHidden = false
        self.DoneButton.isHidden = false
        
        
    }
    
    @IBAction func changeDtaeSecond(_ sender: Any) {
        self.top = true
        self.DatePicker.isHidden = false
        self.DoneButton.isHidden = false
        self.DateView.isHidden = false
    }
    
    @IBAction func ChangeTime(_ sender: Any) {
        
        if txtFirstPl.isEnabled == false , txtSecondPl.isEnabled == false{
           
            self.txtFirstPl.isEnabled = true
            self.txtSecondPl.isEnabled = true
            self.txtSecondPl.borderActiveColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            self.txtFirstPl.borderActiveColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            self.SecondChang.setTitle("Done", for: .normal )
            self.txtFirstPl.layer.borderWidth = 0.5
            self.txtSecondPl.layer.borderWidth = 0.5
            self.txtFirstPl.layer.cornerRadius = 15
            self.txtSecondPl.layer.cornerRadius = 15
            self.txtFirstPl.placeholder = ""
            self.txtSecondPl.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            self.txtSecondPl.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            self.txtSecondPl.placeholder = ""
        

            
            
        }else{
            self.txtFirstPl.isEnabled = false
            self.txtSecondPl.isEnabled = false
            self.txtSecondPl.borderActiveColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.txtFirstPl.borderActiveColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.SecondChang.setTitle("Change", for: .normal)
            self.txtFirstPl.layer.borderWidth = 0
            self.txtSecondPl.layer.borderWidth = 0
            self.txtFirstPl.layer.cornerRadius = 0
            self.txtSecondPl.layer.cornerRadius = 0
            self.txtFirstPl.placeholder = ""
            self.txtSecondPl.placeholder = ""
        }
        
     
        
    }
    @IBAction func DoneTime(_ sender: Any) {
        self.timeView.isHidden = true
        self.DoneTime.isHidden = true
    }
    @IBAction func contiunes(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SummaryVC") as? SummaryVC{
            vc.OrderIDSummary = self.orderIdInformation
            vc.myBokking = self.myBookInformation
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func DoneByn(_ sender: Any) {
        
       self.DoneTime.isHidden = false
        self.DateView.isHidden = true
        self.DoneButton.isHidden = true
        self.timePicker.isHidden  = false
        self.timeView.isHidden = false
        
    }
}
