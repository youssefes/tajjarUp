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


//class API {
//   class func getOrderHistoryOrMy_booking(url : String, complation : @escaping (_ status : Bool,_ data : [[String:Any]]? , _ booKingData : [MyBookingModel]?)->Void){
//        
//        
//        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        
//        Alamofire.request(encodedUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respond) in
//            switch respond.result{
//            case .failure(let error):
//                complation(false, nil,nil)
//                print(error)
//            case .success(let value):
//                let data = JSON(value)
//                var ArrayData = [[String:Any]]()
//                var bookingData = [MyBookingModel]()
//                
//                guard let car_detailes = data["car_detailes"].dictionaryObject else{
//                    print("error to get cars")
//                    return
//                    
//                }
//                guard let id_order = data["id_order"].string else{
//                    return
//                }
//                let date_order = data["date_order"].string
//                let Picking_Up_Date = data["Picking_Up_Date"].string
//                let Picking_Up_locations = data["Picking_Up_locations"].string
//                let Picking_Up_Time = data["Picking_Up_Time"].string
//                let Droping_off_locations = data["Droping_off_locations"].string
//                let Droping_off_Date = data["Droping_off_Date"].string
//                let Droping_off_Time = data["Droping_off_Time"].string
//                guard let additional_specification = data["additional_specification"].arrayObject else{
//                    return
//                }
//                
//                let driver_first_name = data["driver_first_name"].string
//                let driver_last_name = data["driver_last_name"].string
//                let type = data["type"].string
//                let driver_email = data["driver_email"].string
//                let driver_mobile = data["driver_mobile"].string
//                
//                guard let prices_service = data["prices_services"].array else{
//                    return
//                }
//                var prices_servicesArr = [prices_services]()
//                for priceser in prices_service{
//                    let price = priceser["price"].int
//                    let name = priceser["name"].string
//                    let pricServ = prices_services.init(name: name, price: price)
//                    prices_servicesArr.append(pricServ)
//                }
//                
//                let car_Id = data["car_id"].string
//                let total = data["total"].int
//                let total_days = data["total_days"].int
//                let mem_id = data["mem_id"].int
//                let bokkingdata = MyBookingModel.init(id_order: id_order, date_order: date_order, Picking_Up_Date: Picking_Up_Date, Picking_Up_locations: Picking_Up_locations, Picking_Up_Time: Picking_Up_Time, Droping_off_locations: Droping_off_locations!, Droping_off_Date: Droping_off_Date!, Droping_off_Time: Droping_off_Time, additional_specification: additional_specification as? [String], prices_services: prices_servicesArr, Car_Deatiles: nil, total: total, total_days: total_days, car_id: car_Id, mem_id: mem_id, driver_first_name: driver_first_name, driver_last_name: driver_last_name, type: type, driver_email: driver_email, driver_mobile: driver_mobile)
//                bookingData.append(bokkingdata)
//                ArrayData.append(car_detailes)
//                
//                complation(true, ArrayData,bookingData)
//               
//                }
//            }
//        }
//        
//}
