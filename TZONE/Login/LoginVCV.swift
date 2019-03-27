//
//  LoginVCV.swift
//  TZONE
//
//  Created by lapstore on 7/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

import TextFieldEffects



var UserIDToAll = ""
class LoginVCV: Segue {
    @IBOutlet weak var ContainView: UIView!
    @IBOutlet weak var Contain: UIView!

    @IBOutlet weak var imageShoePass: UIImageView!
    @IBOutlet weak var PasswordField: HoshiTextField!
    @IBOutlet weak var EmailField: HoshiTextField!
    
    @IBOutlet weak var RadioButton: UIButton!
    
    @IBOutlet weak var SignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.SignInButton.roundCorners(cornerRadius: 25)
        self.ContainView.roundCorners(cornerRadius: 20)
        self.Contain.roundCorners(cornerRadius: 10)

        RadioButton.setImage(UIImage(named:"Ellipse1"), for: .selected)
        gesterRecognizer()
        // Do any additional setup after loading the view.
    }

    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(x:0,y: 0,width: newSize.width,height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func gesterRecognizer(){
        let Tapregognizer = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        Tapregognizer.numberOfTapsRequired = 1
        self.imageShoePass.addGestureRecognizer(Tapregognizer)
        self.imageShoePass.isUserInteractionEnabled = true
    }
    
    @objc func showPassword(_ sender : UITapGestureRecognizer){
        if  self.PasswordField.isSecureTextEntry == true {
            self.PasswordField.isSecureTextEntry = false
        }else{
            self.PasswordField.isSecureTextEntry = true
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func SignInAction(_ sender: Any) {
        let url = Globals.Login
        let email = EmailField.text!
        let user_pass = PasswordField.text!
        let deviceType = "iOS"
        let parameters = "email=\(email)&user_pass=\(user_pass)&deviceType=\(deviceType)&fmctoken=\(DataManager().callData("GoogleToken"))"
        print(url + parameters)
        Helper.post(url: url + parameters) { (json) in
            if let status = json["status"] as? Int{
                if status == 1 {
                    
                    DispatchQueue.main.async {
                      if self.RadioButton.isSelected == true{
                        if let email_mobile = json["email_mobile"] as? String{
                            DataManager().updateData(email_mobile, Key: "UserEmail")
                        }
                        
                        if let name = json["name"] as? String{
                            DataManager().updateData(name, Key: "UserName")
                        }
                        if let ID = json["ID"] as? String{
                            print("dfsfdsfsdfdsfds")
                            UserIDToAll = ID
                           
                                DataManager().updateData(ID, Key: "ID")
                            
                            
                            }
                        
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "main"){
                            self.present(vc, animated: true, completion: nil)
                        }
                            
                        }
                        
                    }
                    
                }else{
                    if let message = json["message"] as? String{
                        DispatchQueue.main.async {
                            self.showError(message, "OOPS!")
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    @IBAction func DoYouHaveAccount(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC{
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func saveId(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    

}
