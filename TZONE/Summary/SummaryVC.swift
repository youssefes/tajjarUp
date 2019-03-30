//
//  SummaryVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class SummaryVC: UIViewController {
    @IBOutlet weak var ViewDriverDetails: UIView!
    
    @IBOutlet weak var confiermBtn: UIButton!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var DropOffLabel: UILabel!
    @IBOutlet weak var PickUpLabel: UILabel!
    @IBOutlet weak var TotalDaysLabel: UILabel!
    @IBOutlet weak var IncludesLabel: UILabel!
    @IBOutlet weak var CarTitleLabel: UILabel!
    @IBOutlet weak var PhoneLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var ViewSummary: UIView!
    
    var OrderIDSummary = ""
    var myBokking = [MyBookingModel]()
    var AllData = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        if myBokking.count > 0{
            self.ConfirmButton.setTitle("Back To Search", for: .normal)
        }
        // Do any additional setup after loading the view.
        self.ViewDriverDetails.applyShadow()
        self.ViewDriverDetails.roundCorners(cornerRadius: 10)
        self.ViewSummary.applyShadow()
        self.ViewSummary.roundCorners(cornerRadius: 10)

        self.ConfirmButton.roundCorners(cornerRadius: 20)
        GetSummery()

    }
    func GetSummery() {
        let url  = Globals.summery
        let mem_id = DataManager().callData("ID")
        let param = "mem_id=\(mem_id)&order_id=\(OrderIDSummary)"
        Helper.POSTStringTwo(url: url, parameters: param) { (data,status)  in
            guard let json = data else{
                return
            }
            if status{
                
                self.AllData = json
                DispatchQueue.main.async {
                    if let driver_first_name = json["driver_first_name"] as? String{
                        if let driver_last_name = json["driver_last_name"] as? String{
                            if let type = json["type"] as? String{
                                self.NameLabel.text = type + " " + driver_first_name + " " + driver_last_name
                                
                            }
                        }
                        
                    }
                    
                    if let driver_email = json["driver_email"] as? String{
                        self.EmailLabel.text = driver_email
                    }
                    if let driver_mobile = json["driver_mobile"] as? String{
                        self.PhoneLabel.text = driver_mobile
                    }
                    
                    if let Picking_Up_locations = json["Picking_Up_locations"] as? String{
                        self.PickUpLabel.text = Picking_Up_locations
                    }
                    if let Droping_off_locations = json["Droping_off_locations"] as? String{
                        self.DropOffLabel.text = Droping_off_locations
                    }
                    if let total = json["total"] as? Int{
                        self.TotalLabel.text = "\(total)"
                    }
                    
                    if let total_days = json["total_days"] as? Int{
                        self.TotalDaysLabel.text = "\(total_days)"
                    }
                    
                  
                    if let additional_specification = json["additional_specification"] as? [String]{
                        
                       
                        
                        self.IncludesLabel.text = additional_specification.joined(separator: ",")
                        
                    }
                    
                    if let car_Detailes = json["car_detailes"] as? Dictionary <String , Any> {
                        if let title_car = car_Detailes["title_car"] as? String{
                            self.CarTitleLabel.text = title_car
                        }
                    }
                   
                    
                    if let prices_services = json["prices_services"] as? [[String:Any]]{
                        
                        print(prices_services)
                       
                    }
                    
                    
                }
                
            }
          
        }

    }

    @IBAction func confiermBooking(_ sender: UIButton) {
        
        if myBokking.count > 0{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "main"){
                present(vc, animated: true, completion: nil)
            }
        }else{
            if AllData.count > 0{
                if let vc = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderVC") as?
                    PlaceOrderVC{
                    
                    vc.Jsondata = self.AllData
                    
                    present(vc, animated: true, completion: nil)
                    
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
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
