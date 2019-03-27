//
//  Helper.swift
//  TZONE
//
//  Created by lapstore on 12/15/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import Foundation
import SwiftyJSON

class Helper{
    
    static let defaultSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    
    static func POSTString(url: String, parameters: String, complete: @escaping (_: [[String: Any]]? , _ status : Bool)->()) {
        dataTask?.cancel()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(600)
        configuration.timeoutIntervalForResource = TimeInterval(600)
        
        let url = NSURL(string: url)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL as URL)
        //request.addValue(r, forHTTPHeaderField: "Authorization")
        
        
        
        
        request.httpMethod = "POST"
        let postString = parameters
        print("this is parameters:\(postString)")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                complete(nil, false)
            }
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]{
                complete(json, true)
            }
            
            
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        })
        task.resume()
    }
//    
//    static func getImage(_ url_str:String,_ imageView:UIImageView){
//        
//        if url_str != "" {
//            let url = URL(string: url_str)
//            let session = URLSession.shared
//            if url != nil{
//                let task = session.dataTask(with: url!, completionHandler:{(data,response,error) in
//                    if data != nil{
//                        let image = UIImage(data: data!)
//                        if(image != nil) {
//                            
//                            DispatchQueue.main.async(execute:{
//                                
//                                imageView.image = image
//                            })
//                            
//                        }
//                        
//                    }
//                    
//                    
//                })
//                task.resume()
//                
//            }
//            
//        }else{
//            print("zzzz:\(url_str)")
//            
//        }
//        
//    }
    static func GetData(url:String,complete: @escaping (_: [[String:Any]])->()){
        
        
        
        
        let url = NSURL(string: url)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL as URL)
        request.httpMethod = "GET" // make it post if you want
        // request.addValue(r, forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            //do anything you want
            
            guard error == nil else {
                print("NetworkManager - Networking/Request Error:", error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String:Any]] {
                    print("!!!!!!!!",json)
                    complete(json)
                    
                }
                
                
                
            } catch let error as NSError {
                print("NetworkManager - JSON Parsing Error:", error.localizedDescription)
            }
        })
        task.resume()
        
        
        
    }
    
    static func POSTStringTwo(url: String, parameters: String, complete: @escaping (_: [String: Any]?, _ status : Bool)->()) {
        dataTask?.cancel()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(600)
        configuration.timeoutIntervalForResource = TimeInterval(600)
        
        let url = NSURL(string: url)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL as URL)
        //request.addValue(r, forHTTPHeaderField: "Authorization")
        
        
        
        print("this is  url :\(request)")
        request.httpMethod = "POST"
        let postString = parameters
        print("this is parameters:\(postString)")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]{
                if json.count > 0{
                    complete(json,true)
                }else{
                    complete(nil, false)
                }
                
                
                
                
            }
            
            
            
            //let responseString = String(data: data, encoding: .utf8)
            //print("responseString = \(String(describing: responseString))")
        })
        task.resume()
    }
    static func post(url:String,complete: @escaping (_: [String:Any])->()){
        
        let url = NSURL(string: url)
        if url != nil{
          
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url! as URL as URL)
            request.httpMethod = "GET" // make it post if you want
            // request.addValue(r, forHTTPHeaderField: "Authorization")
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                //do anything you want
            
                guard error == nil else {
                    
                    
                    print("NetworkManager - Networking/Request Error:", error!.localizedDescription)
            
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                        
                        complete(json)
                        
                    }
                    
                    
                    
                } catch let error as NSError {
                    print("NetworkManager - JSON Parsing Error:", error.localizedDescription)
                }
            })
            task.resume()

        }
        
        
        
    }
}
