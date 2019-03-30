//
//  NotificationVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    @IBOutlet weak var massage: UILabel!
    
    @IBOutlet weak var carTitel: UILabel!
    @IBOutlet weak var typeCar: UILabel!
    
    @IBOutlet weak var gas_station: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var group: UILabel!
    
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var pages: UILabel!
    
    var carId = ""
    @IBOutlet weak var ViewContainCar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getCarInformation()
        // Do any additional setup after loading the view.
        ViewContainCar.layer.borderWidth = 2.0
        ViewContainCar.layer.borderColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0).cgColor
    }
    

    func getCarInformation(){
    
        API.getCarInformations(carId: carId) { (cardata, success) in
            if success{
                guard let data = cardata else{
                    return
                }
                
                self.setUpViewElement(carDetailsFromModel: data)
                
            }
        }
    }
    
    
    
    func setUpViewElement(carDetailsFromModel: DetailsCarModelById){
        if let title = carDetailsFromModel.title_car{
            carTitel.text = title
            typeCar.text = title
        }
        
        
        if let image = carDetailsFromModel.main_img{
            DispatchQueue.main.async {
                self.image.kf.setImage(with: URL(string: image))
                self.image.kf.indicatorType = .activity
            }
            
        }
      
        if let speed = carDetailsFromModel.speed{
            self.speed.text = speed
        }
        if let carModel = carDetailsFromModel.type_Motor{
            gas_station.text = carModel
        }
        if let page = carDetailsFromModel.total_pages {
            self.pages.text = page
        }
        if let full = carDetailsFromModel.diesel {
            typeCar.text = full
        }
        
    }
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
