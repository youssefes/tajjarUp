//
//  FilterVC.swift
//  TZONE
//
//  Created by lapstore on 12/4/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilterVC: UIViewController {
    @IBOutlet weak var carName: UITextField!
    @IBOutlet weak var carType: UITextField!
    
    @IBOutlet weak var carYear: UITextField!
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var carColor: UITextField!
    
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var FilterButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
self.FilterButton.roundCorners(cornerRadius: 25)
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    @IBAction func getFiltercarBtn(_ sender: Any) {
        
        guard let name = carName.text,!name.isEmpty,let carTypr = carType.text,!carTypr.isEmpty,let color = carColor.text,!color.isEmpty,let model = carModel.text,!model.isEmpty,let year = carYear.text,!year.isEmpty , let price = priceLbl.text else{
            return
        }
        self.getfilterCar(name: name, model: model, color: color, year: year, carType: carTypr, price: price, complatin: { (success, data) in
            if success{
                if (data?.count)! > 0{
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CarDetailsOrCarListVC") as? CarDetailsOrCarListVC {
                        vc.filterlist(json: data!)
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        print("empty Filter")
                    }
                }
                
            }
        })
    }

    func getfilterCar(name : String,model: String, color : String,year: String,carType: String,price: String,complatin :@escaping (_ status : Bool , _ data : [[String:Any]]?)->Void) {
        //http://fmdscu.com/tajjer/json/filter.php?car_id=&car_type=7&car_model&year&color_id&price
        let url = Globals.filter + "car_id=\(name)&car_type=\(carType)&car_model=\(model)&year=\(year)&color_id=\(color)&price=\(price)"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
//        let Parameter : Parameters = [
//            "car_id" : name,
//            "car_model": model,
//            "year" : year,
//            "color_id" : color,
//            "price" : price
//        ]
        Alamofire.request(encodedUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                complatin(false, nil)
                print(error)
            case .success(let value):
                guard let Json = JSON(value).array else{
                    print("no data")
                    return
                }
                var ArrayData = [[String:Any]]()
                for data in Json{
                    guard let dicData = data.dictionaryObject else{
                        return
                    }
                    ArrayData.append(dicData)
                    print("the data filter is \(dicData)")
                }
                complatin(true, ArrayData)
                
            }
        }
    }
    
}
