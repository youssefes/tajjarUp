//
//  Globals.swift
//  TZONE
//
//  Created by lapstore on 12/15/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import Foundation
class Globals {
    static let URL:String = "http://prosolutions-it.com/tajjer/json/"
    static var Rigister : String = URL + "register.php?";
    static var Login : String = URL + "login.php?";
    static var cars_all : String = URL + "cars_all.php?"//???? ask ali
    static var get_all : String = URL + "get_all.php?"
    static var car_list : String = URL + "car_list.php?"//???? ask ali
    static var car_detailes: String = URL + "car_detailes.php?"
    //static var UserDetails : String =  URL + "account_detailes.php?"
    //static var MyTrip : String = URL + "my_trips.php?"
    //static var Completed : String = URL + "completed_trips.php?"
    //static var googleMapApi = "https://maps.googleapis.com/maps/api/geocode/json?"
    //static var notification : String = URL + "notification_user.php?"
    //static var trip_detailes : String = URL + "driver/trip_detailes.php?"
       static var filter = URL + "filter.php?"
    static var order_php : String = URL + "order.php?"
    static var information : String = URL + "information.php?"
    static var summery : String = URL + "summery.php?"
    static let Terms = URL + "terms.php"
    static let help = URL + "help.php"
    static var lng:Double = 0.0
    static var lat:Double = 0.0
    static var Picking_Up_Date = String()
    static var Picking_Up_Time = String()
    static var latitude: Double = 0.0
    static var longtiude: Double = 0.0
    static var Droping_off_Date = String()
    static var Droping_off_Time = String()
    static var Picking_Up_locations = String()
    static var Droping_off_locations = String()
 

}
