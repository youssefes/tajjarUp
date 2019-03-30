//
//  CarDetailsOrCarListVC.swift
//  TZONE
//
//  Created by lapstore on 7/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class CarDetailsOrCarListVC: Segue,UICollectionViewDelegate,UICollectionViewDataSource {
    var BookIngData = [MyBookingModel]()
    var Carelist = [Models]()
    var orderlist = [Models]()
    var Filterlist = [Models]()
    var OrderID = ""
    var titleLa = ""
    var driver : Bool = false
    
    @IBOutlet weak var filtercon: UIView!
    @IBOutlet weak var TopConstarineToCollectionView: NSLayoutConstraint!
    @IBOutlet weak var ViewTopHeader: UIView!
    @IBOutlet weak var Segment: UISegmentedControl!
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var CollectionView: UICollectionView!
    var ShowCarArray: [Models] = [Models]()
    var carIdSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        
        self.TitleLabel.text = titleLa
        print("my bookin data is -> \(BookIngData)")
        print(driver)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CarList()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func CarList() {
        
        if self.Filterlist.count > 0{
            self.Segment.setTitle("Result", forSegmentAt: 1)
        }else if orderlist.count > 0{
            self.TopConstarineToCollectionView.constant = -45
            self.view.setNeedsLayout()
            self.imageLogo.isHidden = true
            self.Segment.isHidden = true
        }else{
            
            self.TitleLabel.isHidden = true
            print("car list count from car list function", self.ShowCarArray.count)
           
                self.Segment.setTitle("List", forSegmentAt: 1)
                let url = Globals.car_list
                let param = "page=1"
                Helper.POSTString(url: url, parameters: param) { (json, status) in
                    if status {
                        guard let json = json else{
                            return
                        }
                        self.ShowCarArray = ParseManager.ParseCars(array: json)
                        self.Carelist = ParseManager.ParseCars(array: json)
                        print("car list is : ", json)
                        DispatchQueue.global().async {
                            DispatchQueue.main.async {
                                self.CollectionView.reloadData()
                            }
                            
                        }
                    }else{
                        self.showError("there are some errors check your connection", "Error")
                    }
                    
                   
            }
        }
        
    }
    func filterlist(json : [[String:Any]])  {
        self.ShowCarArray = ParseManager.ParseCars(array: json)
        self.Filterlist = ParseManager.ParseCars(array: json)
        print("car list is filter : ", json)
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.CollectionView.reloadData()
            }
        }
    }
    
    func orderHistory(json : [[String:Any]]) {
        self.ShowCarArray = ParseManager.ParseCars(array: json)
        self.orderlist = ParseManager.ParseCars(array: json)
        print("car list is order : ", json)
        if self.ShowCarArray.count > 0{
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
            }
        }else{
            print("no data")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ShowCarArray.count > 0 {
            return self.ShowCarArray.count
        }
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarDetailsOrCarListCell", for: indexPath) as! CarDetailsOrCarListCell
       // CarDetailsOrCarListCell.D.isSelected = true
        Cell.CarName.text = self.ShowCarArray[indexPath.row].title_car
        Cell.type_motor.text = self.ShowCarArray[indexPath.row].type_Motor
        
        Cell.Power_motor.text = self.ShowCarArray[indexPath.row].Power_Motor
        Cell.CarBags.text = self.ShowCarArray[indexPath.row].bags
        Cell.Price_offer.text = "$" + self.ShowCarArray[indexPath.row].price_offer
        Cell.Diesel.text = self.ShowCarArray[indexPath.row].Diesel
        Cell.PriceByDay.text = self.ShowCarArray[indexPath.row].price + "Day"
        Cell.Group.text = self.ShowCarArray[indexPath.row].Doors
        let ImageUrl = URL(string: self.ShowCarArray[indexPath.row].main_img)
        DispatchQueue.global(qos: .userInitiated).sync {
            DispatchQueue.main.async {
                Cell.CarImage.kf.indicatorType = .activity
                Cell.CarImage.kf.setImage(with: ImageUrl)
            }
        }
       
        return Cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if BookIngData.count > 0{
            self.carIdSelected = BookIngData[indexPath.row].car_id!
            print(BookIngData[indexPath.row].car_id!)
                self.OrderID = BookIngData[indexPath.row].id_order
        }else if Filterlist.count > 0{
            self.carIdSelected = Filterlist[indexPath.row].ID
            print(Filterlist[indexPath.row].ID)
        }else{
            self.carIdSelected = Carelist[indexPath.row].ID
            print(Carelist[indexPath.row].ID)
        }
        
       if let DetailsCar = self.storyboard?.instantiateViewController(withIdentifier: "DetailsCarVC") as? DetailsCarVC{
            if BookIngData.count > 0{
                DetailsCar.Mybooki = BookIngData
                
            }
            DetailsCar.car_id = carIdSelected
            DetailsCar.orderId = self.OrderID
            DetailsCar.driver = self.driver
        
            present(DetailsCar, animated: true, completion: nil)
        }
        
        
      
    }
    
    
   
    @IBAction func BackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SegmentAction(_ sender: Any) {
        if Segment.selectedSegmentIndex == 0 {
            print("kokokok")
            self.filtercon.isHidden = false
        }else{
            print("ddsdsdsdsds")
            self.filtercon.isHidden = true
        }
    }
    
}
