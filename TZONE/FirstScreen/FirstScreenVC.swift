//
//  FirstScreenVC.swift
//  TZONE
//
//  Created by lapstore on 12/3/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class FirstScreenVC: Segue {

    @IBOutlet weak var SignInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    

  
    @IBAction func SignInAction(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVCV") as? LoginVCV{
            present(vc, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func SkipAction(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "main"){
            present(vc, animated: true, completion: nil)
        }
        
    }
}
