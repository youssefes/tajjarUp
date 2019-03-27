//
//  MoreVC.swift
//  TZONE
//
//  Created by lapstore on 12/4/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class MoreVC: Segue,UITableViewDelegate,UITableViewDataSource {
    var TitleArray = ["Account Details","Register","My Booking","Order History","Contact Us","Settings","Notifications","Terms & Conditions","Help"]
    var Second = [String]()
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var lblemail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageproFile: UIImageView!
    @IBOutlet weak var WelcomeBack: UILabel!
    
    @IBOutlet weak var SecondTableView: UITableView!
    @IBOutlet weak var ViewContainSecondTable: UIView!
    @IBOutlet weak var ViewContainTable: UIView!
    @IBOutlet weak var TableView: UITableView!
    
   
    
    @IBOutlet weak var EditAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableView.delegate = self
        self.TableView.dataSource = self
        self.SecondTableView.delegate = self
        self.SecondTableView.dataSource = self
        setupView()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getdata()
    }
    func setupView(){
        self.ViewContainTable.applyShadow()
        self.ViewContainTable.roundCorners(cornerRadius: 10)
        self.ViewContainSecondTable.applyShadow()
        self.ViewContainSecondTable.roundCorners(cornerRadius: 10)
        self.EditAccount.roundCorners(cornerRadius: 25)
        self.imageproFile.roundCorners(cornerRadius: 33)
    }

    func getdata(){
        
        if let id = DataManager.gatDataByKey(Key:"ID"){
            getUserDetails(id: id) { (sucsses, data) in
                if sucsses{
                    self.Second = [data?.name,data?.email_mobile,data?.mobile,data?.address] as! [String]
                    self.lblName.text = data?.name
                    self.lblemail.text = data?.email
                    if let imageurl = data?.image{

                        if !imageurl.isEmpty{
                            let image = URL(string: imageurl)!
                            self.imageproFile.kf.indicatorType = .activity
                            self.imageproFile.kf.setImage(with: image )
                        }
                        
                    }
                    self.SecondTableView.reloadData()
                    
                }
            }
        }else{
            print("no id")
        }
       
    }
    
    
    @IBAction func SginOut(_ sender: Any) {
        
        DataManager().clearData(true)
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVCV") as? LoginVCV
        self.present(vc!, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == TableView{
            return self.TitleArray.count
            
        }else{
            return self.Second.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell") as! MoreCell
        if tableView == TableView{

            Cell.TitleLabel.text = self.TitleArray[indexPath.row]
            Cell.selectionStyle = .none
        }else{
            
            Cell.TitleLabel.text = Second[indexPath.row]
            Cell.selectionStyle = .none
        }
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == TableView{
            if indexPath.row == 0 {
                self.ViewContainTable.isHidden = true
                self.ViewContainSecondTable.isHidden = false
                self.EditAccount.isHidden = false
                self.WelcomeBack.isHidden = true
                self.BackButton.isHidden = false
                
                self.SecondTableView.reloadData()
            }
            
            if indexPath.row == 1{
            goVC("SignUpVC")
                
                
            }

            if indexPath.row == 2{
              // let url = "http://fmdscu.com/tajjer/json/mybooking.php?mem_id=4
                //self.handelDataByUrl(type : "My Booking",Url: url)
                
                if let id = DataManager.gatDataByKey(Key: "ID") {
                    let url = "http://prosolutions-it.com/tajjer/json/mybooking.php?mem_id=\(id)"
                    self.handelDataByUrl(type: "My Booking",Url: url)
                }else{
                    self.showError("you are Sign out", "Error")
                }
                
            }
            if indexPath.row == 3{
                if let id = DataManager.gatDataByKey(Key: "ID") {
                    let url = "http://prosolutions-it.com/tajjer/json/mybooking.php?mem_id=\(id)"
                    self.handelDataByUrl(type: "order History",Url: url)
                }else{
                    self.showError("you are Sign out", "Error")
                }
               
                
            }
            if indexPath.row == 4{
               goVC("ContactUsVC")
            }
            if indexPath.row == 5{
                goVC("SettingsVC")
            }
            if indexPath.row == 6{
                goVC("NotificationVC")
            }
            if indexPath.row == 7{
               goVC("TermsVC")
            }
            if indexPath.row == 8{
               goVC("HelpVC")
            }
            
        }else{
            if indexPath.row == 0 {
            print("heeeee")
            }
        }
    }
    
    
    @IBAction func EditAccountAction(_ sender: Any) {
        
    }
    
    private func handelDataByUrl(type : String ,Url : String){
        if let id = DataManager.gatDataByKey(Key: "ID"){
            getOrderHistoryOrMy_booking(url: Url,id: id) { (success, data, Databooking) in
                if success {
                    
                    if (data?.count)! > 0{
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CarDetailsOrCarListVC") as? CarDetailsOrCarListVC {
                            vc.orderHistory(json: data!)
                            vc.titleLa = type
                            if (Databooking?.count)! > 0{
                                vc.BookIngData = Databooking!
                            }
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    }else{
                        self.showError("there are some errors check your connection", "Error")
                    }
                    
                    
                }
            }
        }
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.ViewContainTable.isHidden = false
        self.ViewContainSecondTable.isHidden = true
        self.EditAccount.isHidden = true
        self.WelcomeBack.isHidden = false
        self.BackButton.isHidden = true
        self.TableView.reloadData()

    }
}

extension MoreVC{
    func getUserDetails(id : String, complation : @escaping (_ status : Bool, _ data : AcountDetails?)->Void) {
        guard let Url = URL(string: "http://prosolutions-it.com/tajjer/json/account_detailes.php?ID=\(id)") else{
            print("URl faild")
            return
        }
        
        Alamofire.request(Url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                self.showError("There are some Error Chick you InterNet", "Error")
                complation(false, nil)
            case.success(let value):
                let Json = JSON(value)
                print(Json)
                let name = Json["name"].string ?? ""
                let email_mobile = Json["email_mobile"].string ?? ""
                let mobile = Json["mobile"].string ?? ""
                let address = Json["address"].string ?? ""
                let email = Json["email"].string ?? ""
                let image = Json["img"].string ?? ""
                
                let UserData = AcountDetails(name: name, email: email , address: address, mobile: mobile, email_mobile: email_mobile, image: image)
                complation(true, UserData)
            }
        }
        
    }
    
    
    
    func getOrderHistoryOrMy_booking(url : String,id : String, complation : @escaping (_ status : Bool,_ data : [[String:Any]]? , _ booKingData : [MyBookingModel]?)->Void){
        
       
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(encodedUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                complation(false, nil,nil)
                self.showError("There are some Error Chick you InterNet", "Error")
                print(error)
            case .success(let value):
                let json = JSON(value)
                if json.isEmpty {
                    self.showError("NO Booking", "Success")
                }
                var ArrayData = [[String:Any]]()
                var bookingData = [MyBookingModel]()
                if let Alldata = json.array{
                    for data in Alldata{
                        guard let car_detailes = data["car_detailes"].dictionaryObject else{
                            print("error to get cars")
                            return
                            
                        }
                        guard let id_order = data["id_order"].string else{
                            return
                        }
                        let date_order = data["date_order"].string
                        let Picking_Up_Date = data["Picking_Up_Date"].string
                        let Picking_Up_locations = data["Picking_Up_locations"].string
                        let Picking_Up_Time = data["Picking_Up_Time"].string
                        let Droping_off_locations = data["Droping_off_locations"].string
                        let Droping_off_Date = data["Droping_off_Date"].string
                        let Droping_off_Time = data["Droping_off_Time"].string
                        
                        var additonall = [String]()
                        guard let additional_specification =  data["additional_specification"].array else{
                            return
                        }
                        
                        for item in additional_specification{
                            if  let value = item.string{
                                additonall.append(value)
                            }
                            
                            
                        }
                      
                        let driver_first_name = data["driver_first_name"].string
                        let driver_last_name = data["driver_last_name"].string
                        let type = data["type"].string
                        let driver_email = data["driver_email"].string
                        let driver_mobile = data["driver_mobile"].string
                        
                        guard  let car_Detai = data["car_detailes"].dictionary else{
                            return
                        }
                        
                        
                        let ID = (car_Detai["ID"]?.string) ?? ""
                        let Diesel = (car_Detai["Diesel"]?.string) ?? ""
                        let bags = car_Detai["bags"]?.string ?? ""
                        let Doors = car_Detai["Doors"]?.string ?? ""
                        let made_year = car_Detai["made_year"]?.string ?? ""
                        let main_img = car_Detai["main_img"]?.string ?? ""
                        let price = car_Detai["price"]?.string ?? ""
                        let price_offer = car_Detai["price_offer"]?.string ?? ""
                        let type_Motor = car_Detai["type_Motor"]?.string ?? ""
                        let Speed = car_Detai["Speed"]?.string ?? ""
                        let title_car = car_Detai["title_car"]?.string ?? ""
                        guard  let Images = car_Detai["images"]?.array else {
                            return
                        }
                        let Power_Motor = car_Detai["Power_Motor"]?.string ?? ""
                        var imageAr = [String]()
                        var count = 0
                        for image in Images{
                            if let imag =  image["img\(count)"].string{
                                imageAr.append(imag)
                                count = count + 1
                            }
                            
                        }
                        let carDat = DetailsCarModelById.init(title_car: title_car, main_img: main_img, images: imageAr, iD: ID, price: price, price_offer: price_offer, made_year: made_year, diesel: Diesel, type_Motor: type_Motor, power_Motor: Power_Motor, doors: Doors, bags: bags, speed: Speed, total_pages: bags)
                        guard let prices_service = data["prices_services"].array else{
                            return
                        }
                        var prices_servicesArr = [prices_services]()
                    for priceser in prices_service{
                        let price = priceser["price"].int
                        let name = priceser["name"].string
                        let pricServ = prices_services.init(name: name, price: price)
                        prices_servicesArr.append(pricServ)
                    }
                        
                        let car_Id = data["car_id"].string
                        let total = data["total"].int
                        let total_days = data["total_days"].int
                        let mem_id = data["mem_id"].int
                        let bokkingdata = MyBookingModel.init(id_order: id_order, date_order: date_order, Picking_Up_Date: Picking_Up_Date, Picking_Up_locations: Picking_Up_locations, Picking_Up_Time: Picking_Up_Time, Droping_off_locations: Droping_off_locations!, Droping_off_Date: Droping_off_Date!, Droping_off_Time: Droping_off_Time, additional_specification: additonall, prices_services: prices_servicesArr, Car_Deatiles: carDat, total: total, total_days: total_days, car_id: car_Id, mem_id: mem_id, driver_first_name: driver_first_name, driver_last_name: driver_last_name, type: type, driver_email: driver_email, driver_mobile: driver_mobile)
                        bookingData.append(bokkingdata)
                        ArrayData.append(car_detailes)
                    }
                     complation(true, ArrayData,bookingData)
                }else{
                    complation(false, nil,nil)
                    print("error to car dictionary")
                }
            }
        }
        
        
    }
}
