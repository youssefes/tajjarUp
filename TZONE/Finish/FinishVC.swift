//
//  FinishVC.swift
//  TZONE
//
//  Created by lapstore on 12/26/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import SwiftyJSON

class FinishVC: UIViewController {
    
    var allInformation = [String: Any]()
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverEmail: UILabel!
    @IBOutlet weak var totalDay: UILabel!
    
    @IBOutlet weak var Droping_off: UILabel!
    @IBOutlet weak var picking: UILabel!
    @IBOutlet weak var additions: UILabel!
    @IBOutlet weak var carTitel: UILabel!
    @IBOutlet weak var ViewDriverDetails: UIView!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var ViewSummary: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ViewDriverDetails.applyShadow()
        self.ViewDriverDetails.roundCorners(cornerRadius: 10)
        self.ViewSummary.applyShadow()
        self.ViewSummary.roundCorners(cornerRadius: 10)
        
        self.ConfirmButton.roundCorners(cornerRadius: 20)
        seyUpInfo()

    }
    
    func seyUpInfo(){
        if allInformation.count > 0{
            let data = JSON(allInformation)
            print(print("tthis is my finish info\(data)"))
            if let car_details = allInformation[""] as? Dictionary<String, Any>{
                self.carTitel.text = car_details["title_car"] as? String
            }
            
            if let driver_First = allInformation["driver_first_name"] as? String{
                if let driver_last = allInformation["driver_last_name"] as? String{
                    if  let type = allInformation["type"] as? String{
                        self.driverName.text = "\(type) \(driver_First) \(driver_last)"
                    }
                    
                }
            }
            
            if let driveMob = allInformation["driver_mobile"] as? String{
                self.phone.text = driveMob
            }
            
            if let driverEmail = allInformation["driver_email"] as? String{
                self.driverEmail.text = driverEmail
            }
            
            if let indic = allInformation["additional_specification"] as? [String]{
                self.additions.text = indic.joined(separator: ",")
            }
            
            if let total = allInformation["total"] as? Int{
                self.totalDay.text = "\(total)"
            }
            if let picking = allInformation["Picking_Up_locations"] as? String{
                self.picking.text = picking
            }
            
            if let Drop_off = data["Droping_off_locations"].string{
                self.Droping_off.text = Drop_off
            }
            
            
            
        }
    }
    

   
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func finishAction(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "main"){
            present(vc, animated: true, completion: nil)
        }
    }
    
}
