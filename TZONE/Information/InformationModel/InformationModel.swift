//
//  InformationModel.swift
//  TZONE
//
//  Created by amr zayed on 2/6/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//


import Foundation
struct InformationModel : Codable {
    let id_order : String?
    let date_order : String?
    let picking_Up_Date : String?
    let picking_Up_locations : String?
    let picking_Up_Time : String?
    let droping_off_locations : String?
    let droping_off_Date : String?
    let droping_off_Time : String?
    let additional_specification : String?
    let car_id : String?
    let mem_id : String?
    let car_detailes : InformationCar_detailes?
    let driver_first_name : String?
    let driver_last_name : String?
    let type : String?
    let driver_email : String?
    let driver_mobile : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id_order = "id_order"
        case date_order = "date_order"
        case picking_Up_Date = "Picking_Up_Date"
        case picking_Up_locations = "Picking_Up_locations"
        case picking_Up_Time = "Picking_Up_Time"
        case droping_off_locations = "Droping_off_locations"
        case droping_off_Date = "Droping_off_Date"
        case droping_off_Time = "Droping_off_Time"
        case additional_specification = "additional_specification"
        case car_id = "car_id"
        case mem_id = "mem_id"
        case car_detailes = "car_detailes"
        case driver_first_name = "driver_first_name"
        case driver_last_name = "driver_last_name"
        case type = "type"
        case driver_email = "driver_email"
        case driver_mobile = "driver_mobile"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id_order = try values.decodeIfPresent(String.self, forKey: .id_order)
        date_order = try values.decodeIfPresent(String.self, forKey: .date_order)
        picking_Up_Date = try values.decodeIfPresent(String.self, forKey: .picking_Up_Date)
        picking_Up_locations = try values.decodeIfPresent(String.self, forKey: .picking_Up_locations)
        picking_Up_Time = try values.decodeIfPresent(String.self, forKey: .picking_Up_Time)
        droping_off_locations = try values.decodeIfPresent(String.self, forKey: .droping_off_locations)
        droping_off_Date = try values.decodeIfPresent(String.self, forKey: .droping_off_Date)
        droping_off_Time = try values.decodeIfPresent(String.self, forKey: .droping_off_Time)
        additional_specification = try values.decodeIfPresent(String.self, forKey: .additional_specification)
        car_id = try values.decodeIfPresent(String.self, forKey: .car_id)
        mem_id = try values.decodeIfPresent(String.self, forKey: .mem_id)
        car_detailes = try values.decodeIfPresent(InformationCar_detailes.self, forKey: .car_detailes)
        driver_first_name = try values.decodeIfPresent(String.self, forKey: .driver_first_name)
        driver_last_name = try values.decodeIfPresent(String.self, forKey: .driver_last_name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        driver_email = try values.decodeIfPresent(String.self, forKey: .driver_email)
        driver_mobile = try values.decodeIfPresent(String.self, forKey: .driver_mobile)
    }
    
}


struct InformationImages : Codable {
    let img1 : String?
    let img2 : String?
    let img3 : String?
    let img4 : String?
    let img5 : String?
    
    enum CodingKeys: String, CodingKey {
        
        case img1 = "img1"
        case img2 = "img2"
        case img3 = "img3"
        case img4 = "img4"
        case img5 = "img5"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        img1 = try values.decodeIfPresent(String.self, forKey: .img1)
        img2 = try values.decodeIfPresent(String.self, forKey: .img2)
        img3 = try values.decodeIfPresent(String.self, forKey: .img3)
        img4 = try values.decodeIfPresent(String.self, forKey: .img4)
        img5 = try values.decodeIfPresent(String.self, forKey: .img5)
    }
    
}


struct InformationCar_detailes : Codable {
    let title_car : String?
    let main_img : String?
    let iD : String?
    let price : String?
    let price_offer : String?
    let made_year : String?
    let diesel : String?
    let type_Motor : String?
    let power_Motor : String?
    let doors : String?
    let speed : String?
    let bags : String?
    let images : [InformationImages]?
    
    enum CodingKeys: String, CodingKey {
        
        case title_car = "title_car"
        case main_img = "main_img"
        case iD = "ID"
        case price = "price"
        case price_offer = "price_offer"
        case made_year = "made_year"
        case diesel = "Diesel"
        case type_Motor = "type_Motor"
        case power_Motor = "Power_Motor"
        case doors = "Doors"
        case speed = "Speed"
        case bags = "bags"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title_car = try values.decodeIfPresent(String.self, forKey: .title_car)
        main_img = try values.decodeIfPresent(String.self, forKey: .main_img)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        price_offer = try values.decodeIfPresent(String.self, forKey: .price_offer)
        made_year = try values.decodeIfPresent(String.self, forKey: .made_year)
        diesel = try values.decodeIfPresent(String.self, forKey: .diesel)
        type_Motor = try values.decodeIfPresent(String.self, forKey: .type_Motor)
        power_Motor = try values.decodeIfPresent(String.self, forKey: .power_Motor)
        doors = try values.decodeIfPresent(String.self, forKey: .doors)
        speed = try values.decodeIfPresent(String.self, forKey: .speed)
        bags = try values.decodeIfPresent(String.self, forKey: .bags)
        images = try values.decodeIfPresent([InformationImages].self, forKey: .images)
    }
    
}
