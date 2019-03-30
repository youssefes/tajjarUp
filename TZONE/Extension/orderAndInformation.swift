//
//  orderAndInformation.swift
//  TZONE
//
//  Created by youssef on 3/15/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class API {
    
    //MARK:- get car informations by id
    class func getCarInformations(carId : String ,complation : @escaping (_ dataOfCar : DetailsCarModelById?, _ status: Bool )-> Void){
        let url = "http://prosolutions-it.com/tajjer/json/car_detailes.php?ID=\(carId)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print(encodedUrl)
        Alamofire.request(encodedUrl!).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(nil, false)
            case .success(let value):
                print("car dateails Using Alamo \(value)")
                
                let data = JSON(value)
                guard let car_Detai = data.dictionary else{
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
                let Images = car_Detai["images"]?.array
                let Power_Motor = car_Detai["Power_Motor"]?.string ?? ""
                var imageAr = [String]()
                var count = 0
                for image in Images!{
                    if let imag =  image["img\(count)"].string {
                        imageAr.append(imag)
                        count = count + 1
                    }
                    
                }
                let carDat = DetailsCarModelById.init(title_car: title_car, main_img: main_img, images: imageAr, iD: ID, price: price, price_offer: price_offer, made_year: made_year, diesel: Diesel, type_Motor: type_Motor, power_Motor: Power_Motor, doors: Doors, bags: bags, speed: Speed, total_pages: bags)
                complation(carDat, true)
            }
        }
        
    }
    

}
