//
//  DataManager.swift
//  TZONE
//
//  Created by lapstore on 12/15/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import Foundation

class DataManager {
    
    func callData(_ key:String)->String {
        if let calledData = UserDefaults.standard.string(forKey: key){
            return calledData
        }
        else  if let calledData = UserDefaults.standard.string(forKey: key){
            return calledData
            
        }
        return "";
    }
    
    class func gatDataByKey(Key:String) -> String?{
     let data = UserDefaults.standard.string(forKey: "ID")
        return data
    }
    
    func updateData (_ Value:String , Key:String) {
        UserDefaults.standard.setValue(Value, forKey: Key)
        UserDefaults.standard.synchronize()
        print("done")
    }
    
    func clearData (_ all: Bool) {
        for key in Array(UserDefaults.standard.dictionaryRepresentation().keys) {
            // to avoid clear apple token when user signs out
            if all == false {
                if key != "appleToken" {
                    UserDefaults.standard.removeObject(forKey: key)
                }
            } else {
                UserDefaults.standard.removeObject(forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
