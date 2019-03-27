//
//  EditProfileVC.swift
//  TZONE
//
//  Created by lapstore on 12/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import Photos

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var containerImageProfil: UIView!
    @IBOutlet weak var ProfilImage: UIImageView!
    @IBOutlet weak var yourPhone: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var imageLocation: UIImageView!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var SaveChanges: UIButton!
    @IBOutlet weak var ViewContainFields: UIView!
    
    let AuthorizationStatus = CLLocationManager.authorizationStatus()
    let locationManager = CLLocationManager()
    var address = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        containerImageProfil.layer.cornerRadius = 50
        containerImageProfil.layer.masksToBounds = true
        GesterRecognizerFu()
        checkLocationManger()
        getNameOfLocation()
        // Do any additional setup after loading the view.
        self.ViewContainFields.applyShadow()
        self.ViewContainFields.roundCorners(cornerRadius: 15)
        self.SaveChanges.roundCorners(cornerRadius: 25)
    }
    
    func GesterRecognizerFu(){
        
        let Tapregognizer = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        Tapregognizer.numberOfTapsRequired = 1
        self.imageLocation.addGestureRecognizer(Tapregognizer)
        self.imageLocation.isUserInteractionEnabled = true
        
        let TapregognizerIm = UITapGestureRecognizer(target: self, action: #selector(showAllImageToChose))
        TapregognizerIm.numberOfTapsRequired = 1
        self.ProfilImage.addGestureRecognizer(TapregognizerIm)
        self.ProfilImage.isUserInteractionEnabled = true
    }
    
    
    func showAlert(message : String,Titel : String){
        let alert = UIAlertController(title: Titel, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showAllImageToChose(_ sender : UITapGestureRecognizer){
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    
    }
    
    @objc func showPassword(_ sender : UITapGestureRecognizer){

        
        if  self.password.isSecureTextEntry == true {
            self.password.isSecureTextEntry = false
        }else{
            self.password.isSecureTextEntry = true
        }
        
    }
    
    func getNameOfLocation(){
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
                    self.address.append(zip)
                    print(zip)
                }
                // Country
                if let country = placeMark.country {
                    self.address.append(country)
                    print(country)
                }
                
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
            checkAuthorizationStaus()
        }else{
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveChangesAction(_ sender: Any) {
        
        guard let email = email.text,!email.isEmpty,let password = password.text,!password.isEmpty,let name = userName.text, !name.isEmpty,let phone = yourPhone.text, !phone.isEmpty else{
            return
        }
        let id = DataManager().callData("ID")
        print(id)
        let UploadeImage = UIImagePNGRepresentation(self.ProfilImage.image!)
        let Address = self.address.joined(separator: "-")
        EditProfileAPI(user_pass: password, id: id , name: name, email: email, mobile: phone, address: Address, image: nil) { (massage, status) in
            
            if status {
               
                self.showAlert(message: massage!, Titel: "Info")
            }
            
        }
       // self.dismiss(animated: true, completion: nil)
    }
}
extension EditProfileVC{
    func EditProfileAPI(user_pass: String,id: String,name: String, email: String, mobile:String,address:String,image: String?, complatio : @escaping (_ dataMassage : String?, _ status : Bool)->Void) {
        print(" my address is\(address)")
      let url = "http://prosolutions-it.com/tajjer/json/change_pass.php?ID=\(id)&name=\(name)&email=\(email)&mobile=\(mobile)&img=\(image)&address=\(address)"
        
   
    let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let parameters : Parameters  = [
//            "user_pass" : user_pass,
//            "name" : name,
//            "email" : email,
//            "mobile" : mobile,
//            "address" : address,
//            "img" : image
//            ]
        
        
        Alamofire.request(encodedUrl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (respond) in
            switch respond.result{
                
            case .failure(let error):
                print(" the is an error ->\(error)")
            case .success(let value):
                let json = JSON(value)
                guard let dataMassage = json["message"].string else {
                    complatio(nil, false)
                    return
                }
                print(dataMassage)
                complatio(dataMassage, true)
                
            }
        }
    }
}

extension EditProfileVC : CLLocationManagerDelegate{
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
extension EditProfileVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editImage = info[UIImagePickerControllerEditedImage]
            as? UIImage{
            self.ProfilImage.image = editImage
            self.containerImageProfil.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            self.ProfilImage.layer.cornerRadius = 50
            
            print(editImage)
            if  let imageUrl = info[UIImagePickerControllerImageURL] as? NSURL {
                if let imageName = imageUrl.lastPathComponent{
                    print(imageName)
                }

            }
            
        }else{
            let original = info[UIImagePickerControllerOriginalImage] as? UIImage
                self.ProfilImage.image = original
                self.containerImageProfil.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                self.ProfilImage.layer.cornerRadius = 50
            if let image = original{
                print(image)
            }
                print(original)
            
            
        }
        dismiss(animated: true, completion: nil)
    }
}
