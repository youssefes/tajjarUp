//
//  SignUpVC.swift
//  TZONE
//
//  Created by lapstore on 12/3/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import TextFieldEffects
import DLRadioButton

class SignUpVC: Segue {
    
    @IBOutlet weak var imageShowPass: UIImageView!
    @IBOutlet weak var ContainView: UIView!
    
    @IBOutlet weak var YourNameField: HoshiTextField!
    
    @IBOutlet weak var EmailField: HoshiTextField!
    
    
    @IBOutlet weak var Passwordfield: HoshiTextField!
    
    @IBOutlet weak var RadioButton: UIButton!
    
    @IBOutlet weak var SignInButton: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.gesterRecognizer()
        self.SignInButton.roundCorners(cornerRadius: 25)
        self.ContainView.roundCorners(cornerRadius: 10)
        
        RadioButton.setImage(UIImage(named:"Ellipse1"), for: .selected)
        
        // Do any additional setup after loading the view.
    }
    func gesterRecognizer(){
        let Tapregognizer = UITapGestureRecognizer(target: self, action: #selector(showPassword))
        Tapregognizer.numberOfTapsRequired = 1
        self.imageShowPass.addGestureRecognizer(Tapregognizer)
        self.imageShowPass.isUserInteractionEnabled = true
    }
    
    @objc func showPassword(_ sender : UITapGestureRecognizer){
        if  self.Passwordfield.isSecureTextEntry == true {
            self.Passwordfield.isSecureTextEntry = false
        }else{
            self.Passwordfield.isSecureTextEntry = true
        }
        
    }
    

    @IBAction func checkBoxBtn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
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
    
    @IBAction func SignInAction(_ sender: Any) {
        let url = Globals.Rigister
        let fullname = YourNameField.text!
        let email_mobile = EmailField.text!
        let user_pass = Passwordfield.text!
        let parameters = "fullname=\(fullname)&email_mobile=\(email_mobile)&user_pass=\(user_pass)"
        Helper.post(url: url + parameters) { (json) in
            if let status = json["status"] as? Int{
                if status == 1 {
                    
                    DispatchQueue.main.async {
                        
                            if let name = json["name"] as? String{
                                DataManager().updateData(name, Key: "UserName")
                            }
                         let ID = "\(String(describing: json["ID"] as! Int))"
                                print(ID)
                                UserIDToAll = ID
                                if self.RadioButton.isSelected == true{
                                    
                                    
                                    DataManager().updateData(ID, Key: "ID")
                            }
                            if let email_mobile = json["email_mobile"] as? String{
                                DataManager().updateData(email_mobile, Key: "UserEmail")
                            }
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "main"){
                            self.present(vc, animated: true, completion: nil)
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
    
    
    @IBAction func signinaction(_ sender: Any) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCV"){
            self.present(vc, animated: true, completion: nil)
        }
    }
}

