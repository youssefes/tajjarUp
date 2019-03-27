//
//  NetworkingManager.swift
//  TZONE
//
//  Created by amr zayed on 2/2/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//

import Foundation
class NetworkingManager{
    static let defaultSession = URLSession(configuration: .default)
    static var dataTask: URLSessionDataTask?
    
    static func POSTStringWithModelGeniric<T: Decodable>(url: String, parameters: String, complete: @escaping (T)->()) {
        dataTask?.cancel()
        //guard let token = DataManager().callData("token") else {return}
        //let r = "Bearer" + " " +  token//DataManager().callData("token")
        //print(r)
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(600)
        configuration.timeoutIntervalForResource = TimeInterval(600)
        
        let url = NSURL(string: url)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url! as URL as URL)
        //request.addValue(token, forHTTPHeaderField: "Authorization")
        
        
        //x-www-form-urlencoded
        print("this is  url :\(request)")
        request.httpMethod = "POST"
        let postString = parameters
        print("this is parameters:\(postString)")
        request.setValue("application//x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: .utf8)
        print("Request",request)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            if let json = try? JSONDecoder().decode(T.self, from: data){
                complete(json)
            }
            
            
        })
        task.resume()
    }
}
