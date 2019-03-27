//
//  MyBookingModel.swift
//  TZONE
//
//  Created by youssef on 3/14/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//

import Foundation
import MapKit
import SwiftyJSON

/*
 "id_order": "65",
 "date_order": null,
 "Picking_Up_Date": "2018-09-10",
 "Picking_Up_locations": "AAAAAAAAAA",
 "Picking_Up_Time": "9:00pm",
 "Droping_off_locations": "HHHHHHH",
 "Droping_off_Date": "2018-09-15",
 "Droping_off_Time": "10:00pm",
 "additional_specification": [
 "GPS Navigation",
 "Child Seat"
 ],
 "prices_services": [
 {
 "name": "BMW 2 Series",
 "price": 750
 }
 ],
 "total": 3250,
 "total_days": 5,
 "car_id": "4",
 "mem_id": null,
 "driver_first_name": "ali",
 "driver_last_name": "elkady",
 "type": "Mr",
 "driver_email": "diver@yahoo.com",
 "driver_mobile": "012840025925"
 
 */
struct MyBookingModel {
    var id_order : String
    var date_order : String?
    var Picking_Up_Date: String?
    var Picking_Up_locations: String?
    var Picking_Up_Time : String?
    var Droping_off_locations : String
    var Droping_off_Date : String
    var Droping_off_Time : String?
    var additional_specification : [String]?
    var prices_services : [prices_services]?
    var Car_Deatiles : DetailsCarModelById?
    var total:Int?
    var total_days : Int?
    var car_id : String?
    var mem_id : Int?
    var driver_first_name: String?
    var driver_last_name : String?
    var type : String?
    var driver_email : String?
    var driver_mobile : String?
}
struct prices_services {
    var name : String?
    var price : Int?
}
