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
        
        goVC("LoginVCV")
        
        
    }
    
    @IBAction func SkipAction(_ sender: Any) {
        
        goVC("main")
    }
}
