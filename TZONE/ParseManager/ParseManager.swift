//
//  ParseManager.swift
//  TZONE
//
//  Created by lapstore on 12/26/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import Foundation
class ParseManager{
    
    static func ParseCars (array: [[String:Any]]) -> [Models] {
        var FriendsArray: [Models] = [Models]()
        for each in array {
            let friends: Models = Models()
            if let title_car = each["title_car"] as? String {
                friends.title_car = title_car
            }
            
            if let main_img = each["main_img"] as? String {
                friends.main_img = main_img
            }
            if let ID = each["ID"] as? String {
                friends.ID = ID
            }
            if let price = each["price"] as? String {
                friends.price = price
            }
            if let price_offer = each["price_offer"] as? String {
                friends.price_offer = price_offer
            }

            if let made_year = each["made_year"] as? String {
                friends.made_year = made_year
            }
            if let Diesel = each["Diesel"] as? String {
                friends.Diesel = Diesel
            }
            if let type_Motor = each["type_Motor"] as? String {
                friends.type_Motor = type_Motor
            }
            if let Power_Motor = each["Power_Motor"] as? String {
                friends.Power_Motor = Power_Motor
            }

            if let Doors = each["Doors"] as? String {
                friends.Doors = Doors
            }
            if let bags = each["bags"] as? String {
                friends.bags = bags
            }
            if let Speed = each["Speed"] as? String {
                friends.Speed = Speed
            }
            if let total_pages = each["total_pages"] as? String {
                friends.total_pages = total_pages
            }

            FriendsArray.append(friends)
        }
        return FriendsArray
    }
    
    
    static func ParseGetAll (array: [[String:Any]]) -> [GetAll] {
        var FriendsArray: [GetAll] = [GetAll]()
        for each in array {
            let friends: GetAll = GetAll()
            if let id = each["id"] as? String {
                friends.id = id
            }
            if let price = each["price"] as? String {
                friends.price = price
            }
            if let name = each["name"] as? String {
                friends.name = name
            }
            
            FriendsArray.append(friends)
        }
        return FriendsArray
    }
}
