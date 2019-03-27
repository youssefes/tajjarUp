//
//  HomeVC.swift
//  TZONE
//
//  Created by lapstore on 8/15/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreLocation

class HomeVC: Segue,UITextFieldDelegate {
// AIzaSyAFwNRXCjYgil066cynflbFzcyNs3hae-4
    
    let AuthorizationStatus = CLLocationManager.authorizationStatus()
    let locationManager = CLLocationManager()
    var address = [String]()
    @IBOutlet weak var ShowCar: UIButton!
    @IBOutlet weak var PickUpLocationTextField: HoshiTextField!
    
    @IBOutlet weak var DropOfLocationTextfield: HoshiTextField!
    
    @IBOutlet weak var LeftView: UIView!
    @IBOutlet weak var SwitchanotherLocation: UISwitch!
    
    @IBOutlet weak var RightView: UIView!
    @IBOutlet weak var SwitchDriverAge: UISwitch!
    
    @IBOutlet weak var ContainView: UIView!
    
    @IBOutlet weak var FirstPopUpLabel: UILabel!
    
    @IBOutlet weak var SecondPopUpLabel: UILabel!
    
    @IBOutlet weak var DayLeftLabel: UILabel!
    
    @IBOutlet weak var MonthLeftLabel: UILabel!
    
    @IBOutlet weak var NumberLeftLabel: UILabel!
    
    @IBOutlet weak var TimeLeftLabel: UILabel!
    
    @IBOutlet weak var NumberRightLabel: UILabel!
    
    @IBOutlet weak var DayRightLabel: UILabel!
    
    @IBOutlet weak var MonthRightLAbel: UILabel!
    
    @IBOutlet weak var TimeRightLabel: UILabel!
    
    @IBOutlet weak var ViewDate: UIView!
    
    @IBOutlet weak var ViewTime: UIView!
    
    @IBOutlet weak var DropLocatin: UIImageView!
    @IBOutlet weak var TimePicker: UIDatePicker!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var imageGetMyLocation: UIImageView!
    
    @IBOutlet weak var DoneButton: UIButton!
    
    var left = false
    var Picking_Up_Date = String()
    var Droping_off_Date = String()
    var Picking_Up_Time = String()
    var Droping_off_Time = String()
    var ShowCarArray: [Models] = [Models]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViwe()
        checkLocationManger()
        setLocationName()
        
        // Do any additional setup after loading the view.
    }
    func setupViwe(){
        self.ContainView.roundCorners(cornerRadius: 10)
        self.ShowCar.roundCorners(cornerRadius: 25)
        self.ContainView.applyShadow()
        self.LeftView.applyShadow()
        self.RightView.applyShadow()
        DatePicker.addTarget(self, action: #selector(datePickerValueEnd), for: .valueChanged)
        TimePicker.addTarget(self, action: #selector(datePickerValue), for: .valueChanged)
        
        self.hideKeyboardWhenTappedAround()
        self.DoneButton.isHidden = true
        self.ViewTime.isHidden = true
        self.ViewDate.isHidden = true
        self.DropOfLocationTextfield.delegate = self
        self.PickUpLocationTextField.delegate = self
        
        
    }
    func setLocationName(){
        let Tapregognizer = UITapGestureRecognizer(target: self, action: #selector(getNameOfLocation))
        Tapregognizer.numberOfTapsRequired = 1
        self.imageGetMyLocation.addGestureRecognizer(Tapregognizer)
        self.imageGetMyLocation.isUserInteractionEnabled = true
        
        let TapregognizerD = UITapGestureRecognizer(target: self, action: #selector(getNameOfLocation))
        TapregognizerD.numberOfTapsRequired = 1
        self.DropLocatin.addGestureRecognizer(TapregognizerD)
        self.DropLocatin.isUserInteractionEnabled = true
    }
    @objc func datePickerValueEnd(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        if self.left == true{
            dateFormatter.dateFormat = "d"
            NumberLeftLabel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "EEE"
            DayLeftLabel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "MMM"
            MonthLeftLabel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            Picking_Up_Date = dateFormatter.string(for: sender.date)!

        }else{
            dateFormatter.dateFormat = "d"
            NumberRightLabel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "EEE"
            DayRightLabel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "MMM"
            MonthRightLAbel.text = dateFormatter.string(for: sender.date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            Droping_off_Date = dateFormatter.string(for: sender.date)!


        }

        
    }
    @objc func datePickerValue(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        if self.left == true{
            dateFormatter.dateFormat = "HH:mm a"
            TimeLeftLabel.text = "Time: " + dateFormatter.string(for: sender.date)!
            Picking_Up_Time = dateFormatter.string(for: sender.date)!
        }else{
            dateFormatter.dateFormat = "HH:mm a"
            TimeRightLabel.text = "Time: " + dateFormatter.string(for: sender.date)!
            Droping_off_Time = dateFormatter.string(for: sender.date)!
        }
        
    }
    
    @objc func getNameOfLocation(){
        self.address.removeAll()
        if let coordinate = locationManager.location?.coordinate{
            let long = coordinate.longitude
            let lat = coordinate.latitude
            let gecoder = CLGeocoder()
            let location = CLLocation(latitude: lat, longitude: long)
            gecoder.reverseGeocodeLocation(location) { (placesMark, error) in
                guard let placeMark = placesMark?.first else { return }
                
                // Location name
                if let locationName = placeMark.location {
                    print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    self.address.append(street)
                    print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    self.address.append(city)
                    print(city)
                }
                // Zip code
                if let zip = placeMark.isoCountryCode {
                    print(zip)
                }
                // Country
                if let country = placeMark.country {
                    self.address.append(country)
                }
                if  !(self.PickUpLocationTextField.text?.isEmpty)!{
                    self.DropOfLocationTextfield.text = self.address.joined(separator: "/")
                }
                self.PickUpLocationTextField.text = self.address.joined(separator: "/")
                
            }
        }
        
    }
    
    func setupLocationManger(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationManger(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManger()
            self.checkAuthorizationStaus()
        }else{
            
        }
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "OpenDetails"{
            let CarDetails = segue.destination as! CarDetailsOrCarListVC
            CarDetails.ShowCarArray = self.ShowCarArray
            
        }
    }
 
    @IBAction func DateLeftButton(_ sender: Any) {
        self.left = true
        self.ViewDate.isHidden = false
        self.ViewTime.isHidden = true
        self.DoneButton.isHidden = false
        
    }
    @IBAction func TimeLeftButton(_ sender: Any) {
        self.left = true
        self.ViewDate.isHidden = true
        self.ViewTime.isHidden = false
        self.DoneButton.isHidden = false

    }
    
    @IBAction func DateRightButton(_ sender: Any) {
        self.left = false
        self.ViewDate.isHidden = false
        self.ViewTime.isHidden = true
        self.DoneButton.isHidden = false


    }
    
    @IBAction func TimeRightButton(_ sender: Any) {
        self.left = false
        self.ViewDate.isHidden = true
        self.ViewTime.isHidden = false
        self.DoneButton.isHidden = false

    }
    
    @IBAction func DoneAction(_ sender: Any) {
        self.ViewDate.isHidden = true
        self.ViewTime.isHidden = true
        self.DoneButton.isHidden = true
        
    }
    @IBAction func ShowCarAction(_ sender: Any) {
        let Picking_Up_locations = self.PickUpLocationTextField.text!
        let Droping_off_locations = self.DropOfLocationTextfield.text!
        if Picking_Up_locations == "" || Droping_off_locations == "" || Picking_Up_Date == "" || Droping_off_Date == "" || Picking_Up_Time == "" || Droping_off_Time == ""{
        
            showError("you must enter the date and time and locations ", "ERROR")
        }else{
            Globals.Picking_Up_Date = self.Picking_Up_Date
            Globals.Droping_off_Date = self.Droping_off_Date
            Globals.Picking_Up_Time = self.Picking_Up_Time
            Globals.Droping_off_Time = self.Droping_off_Time
            Globals.Picking_Up_locations = Picking_Up_locations
            Globals.Droping_off_locations = Droping_off_locations
            var driver : Bool = SwitchDriverAge.isOn
            print(driver)
            
            
            let url = Globals.cars_all
            let param = "page=1&Picking_Up_Date=\(Picking_Up_Date)&Droping_off_Date=\(Droping_off_Date)&Picking_Up_Time=\(Picking_Up_Time)&Droping_off_Time=\(Droping_off_Time)&Picking_Up_locations=\(Picking_Up_locations)&Droping_off_locations=\(Droping_off_locations)"
            Helper.POSTString(url: url, parameters: param) { (json,status) in
                if status{
                    guard let json = json else {
                        return
                        
                    }
                    self.ShowCarArray = ParseManager.ParseCars(array: json)
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CarDetailsOrCarListVC") as? CarDetailsOrCarListVC
                        vc?.driver = driver
                        
                        self.present(vc!, animated: true, completion: nil)
                    }
                }else{
                    self.showError("there are some errors check your connection", "Error")
                }
                
                
            }
        }
    }
        
    
}

extension HomeVC : CLLocationManagerDelegate{
    func checkAuthorizationStaus(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStaus()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        let locationIncenter = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        print(locationIncenter)
        
        
    }
}
