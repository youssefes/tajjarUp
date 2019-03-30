//
//  DetailsCarVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailsCarVC: UIViewController {

    @IBOutlet weak var ViewContainImage: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var PriceBaby: UILabel!
    @IBOutlet weak var BabySeat: UILabel!
    @IBOutlet weak var PriceChild: UILabel!
    @IBOutlet weak var ChildSeat: UILabel!
    @IBOutlet weak var PriceAdditinal: UILabel!
    @IBOutlet weak var Addetional: UILabel!
    @IBOutlet weak var PriceNav: UILabel!
    @IBOutlet weak var GPSNavigation: UILabel!
    @IBOutlet weak var CarDoors: UILabel!
    @IBOutlet weak var CarGray: UILabel!
    @IBOutlet weak var CarNew: UILabel!
    @IBOutlet weak var CarYear: UILabel!
    @IBOutlet weak var CarType: UILabel!
    @IBOutlet weak var PriceDayLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var GreatLabel: UILabel!
    @IBOutlet weak var CarImage: UIImageView!
    @IBOutlet weak var BookThisCar: UIButton!
    @IBOutlet weak var ViewContainRadio: UIView!
    
    @IBOutlet weak var checkButton1: UIButton!
    
    @IBOutlet weak var checkButton2: UIButton!
    @IBOutlet weak var checkButton3: UIButton!
    
    @IBOutlet weak var checkButton4: UIButton!
    
    var getAll = [GetAll]()
    var car_id = String()
    var RaOne = String()
    var RaTwo = String()
    var roThree = String()
    var roFour = String()
    var orderId = ""
    var driver : Bool = false
    var additional_specification = [String]()
     var check = false
    var Mybooki = [MyBookingModel]()
    var carId  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("car id : ", car_id)
        // Do any additional setup after loading the view.
        setupView()
        self.get_all()
        get_data(Mybooki: Mybooki)
    
    }
    
    
    
    
    func setupView(){
        self.ViewContainImage.applyShadow()
        self.ViewContainImage.roundCorners(cornerRadius: 10)
        self.ViewContainRadio.applyShadow()
        self.ViewContainRadio.roundCorners(cornerRadius: 10)
        self.BookThisCar.roundCorners(cornerRadius: 25)
        self.checkButton4.borderwidth = 2
        self.checkButton4.roundCorners(cornerRadius: 10)
        self.checkButton4.bordercolor = #colorLiteral(red: 0.05490196078, green: 0.5882352941, blue: 0.9450980392, alpha: 1)
        self.checkButton3.borderwidth = 2
        self.checkButton3.roundCorners(cornerRadius: 10)
        self.checkButton3.bordercolor = #colorLiteral(red: 0.05490196078, green: 0.5882352941, blue: 0.9450980392, alpha: 1)
        self.checkButton2.borderwidth = 2
        self.checkButton2.roundCorners(cornerRadius: 10)
        self.checkButton2.bordercolor = #colorLiteral(red: 0.05490196078, green: 0.5882352941, blue: 0.9450980392, alpha: 1)
        self.checkButton1.borderwidth = 2
        self.checkButton1.roundCorners(cornerRadius: 10)
        self.checkButton1.bordercolor = #colorLiteral(red: 0.05490196078, green: 0.5882352941, blue: 0.9450980392, alpha: 1)
        
        checkButton4.setImage(UIImage(named:"Ellipse1"), for: .selected)
        checkButton3.setImage(UIImage(named:"Ellipse1"), for: .selected)
        checkButton2.setImage(UIImage(named:"Ellipse1"), for: .selected)
        checkButton1.setImage(UIImage(named:"Ellipse1"), for: .selected)
        
    }
   
    
    func get_data(Mybooki :[MyBookingModel]){
        
        
        if Mybooki.count > 0 {
            for selectedBooking in Mybooki{
                if selectedBooking.id_order == self.orderId{
                    self.setUpViewElement(carDetailsFromModel: selectedBooking.Car_Deatiles!)
                    self.BookThisCar.setTitle("More Information", for: .normal)
                    for selected in selectedBooking.additional_specification!{
                        switch selected{
                        case "GPS Navigation":
                            self.checkButton1.isSelected = true
                        case "Child Seat" :
                            self.checkButton2.isSelected = true
                        case "Baby Seat":
                            self.checkButton3.isSelected = true
                        case "Additional Driver":
                            self.checkButton4.isSelected = true
                        default:
                            print("empty Addtion")
                        }
                    }
                    
                }
            }
        }else{
            API.getCarInformations(carId : car_id) { (cardata, success) in
                if success{
                    if let data = cardata{
                        self.setUpViewElement(carDetailsFromModel: data)
                    }
                
                }else{
                    print("no data for car")
                }
            }
        }
        
    }

    
    //MARK:- setup view Element
    func setUpViewElement(carDetailsFromModel: DetailsCarModelById){
        if let title = carDetailsFromModel.title_car{
            TitleLabel.text = title
            CarType.text = title
        }
        if let price = carDetailsFromModel.price{
            PriceLabel.text = "$\(price)"
        }
        if let offerDay = carDetailsFromModel.price_offer{
            PriceDayLabel.text = "$\(offerDay)/Day"
        }
        
        if let image = carDetailsFromModel.main_img{
            DispatchQueue.main.async {
                self.CarImage.kf.setImage(with: URL(string: image))
                self.CarImage.kf.indicatorType = .activity
            }
            
        }
        if let doors = carDetailsFromModel.doors{
            CarDoors.text = doors
        }
        if let speed = carDetailsFromModel.speed{
            CarNew.text = speed
        }
        if let carModel = carDetailsFromModel.made_year{
            CarYear.text = carModel
        }
        
    }
    
    //MARK:- additional specification add to car if i want
    func get_all(){
        let url = Globals.get_all
        let param = "type=1"
        Helper.POSTString(url: url, parameters: param) { (json, status) in
            
            if status {
                
                guard let json = json else {
                    return
                }
                self.getAll = ParseManager.ParseGetAll(array: json)
                DispatchQueue.main.async {
                    if self.getAll.count > 0 {
                        self.GPSNavigation.text = self.getAll[0].name
                        self.PriceNav.text = "$" + self.getAll[0].price + "/Day"
                        self.ChildSeat.text = self.getAll[1].name
                        self.PriceChild.text = "$" + self.getAll[1].price + "/Day"
                        self.Addetional.text = self.getAll[2].name
                        self.PriceAdditinal.text = "$" + self.getAll[2].price + "/Day"
                        self.BabySeat.text = self.getAll[3].name
                        self.PriceBaby.text = "$" + self.getAll[3].price + "/Day"
                        
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

    func checkCode(_ sender : UIButton){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    @IBAction func checkButton1(_ sender: UIButton) {
        checkCode(sender)
    }
    
    @IBAction func checkButton2(_ sender: UIButton) {
        checkCode(sender)
    }
    
    @IBAction func checkButton3(_ sender: UIButton) {
        checkCode(sender)
    }
    
    
    @IBAction func checkButton4(_ sender: UIButton) {
       checkCode(sender)
    }
    
    
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BookCar(_ sender: Any) {
        if Mybooki.count > 0{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformationVC") as? InformationVC{
                vc.orderIdInformation = self.orderId
                vc.myBookInformation = self.Mybooki
                self.present(vc, animated: true, completion: nil)
            }
            
            
        }else{
            orderCar { (success, orderId, message) in
                if success{
                    
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformationVC") as? InformationVC{
                        vc.orderIdInformation = orderId!
                        vc.myBookInformation = self.Mybooki
                        
                        
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    
                }
            }
        }
    }
}

extension DetailsCarVC {
    
    
    func checkText(str: String){
        switch str{
        case "GPS Navigation":
            self.additional_specification.append("1")
        case "Child Seat" :
            self.additional_specification.append("2")
        case "Baby Seat":
            self.additional_specification.append("3")
        case "Additional Driver":
            self.additional_specification.append("4")
        default:
            print("empty Addtion")
        }
    }
    
    func orderCar(complation:@escaping (_ status : Bool , _ order_id : String?,_ massage: String?)-> Void){
        
        if self.checkButton1.isSelected {
            if let add1 = self.GPSNavigation.text {
                 checkText(str: add1)
                
            }
        }
        
        if self.checkButton2.isSelected {
            if let add1 = self.ChildSeat.text {
                 checkText(str: add1)
            }
        }
        
        if self.checkButton3.isSelected {
            if let add1 = self.Addetional.text {
               checkText(str: add1)
            }
        }
        
        if self.checkButton4.isSelected {
            if let add1 = self.BabySeat.text {
                checkText(str: add1)
            }
        }
        
       
        
        print(additional_specification)
        let mem_id = DataManager().callData("ID")
        let url = "http://prosolutions-it.com/tajjer/json/order.php?mem_id=\(mem_id)&car_id=\(car_id)&Picking_Up_Date=\(Globals.Picking_Up_Date)&Droping_off_Date=\(Globals.Droping_off_Date)&Picking_Up_Time=\(Globals.Picking_Up_Time)&Droping_off_Time=\(Globals.Droping_off_Time)&Picking_Up_locations=\(Globals.Picking_Up_locations)&Droping_off_locations=\(Globals.Droping_off_locations)&additional_specification=\(self.additional_specification)"
        print("this order url \(url)")
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        Alamofire.request(encodedUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (Respond) in
            switch Respond.result{
            case .failure(let error):
                print(error)
                complation(false, nil,nil)
                self.showError("there are some error chuck your connaction", "Error")
            case .success(let value):
                let json = JSON(value)
                let order_Id = json["order_id"].stringValue
                let message = json["message"].stringValue
                
                complation(true, order_Id, message)
            }
        }
        
        
    }
}
