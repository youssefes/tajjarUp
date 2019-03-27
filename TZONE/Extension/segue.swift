//
//  segue.swift
//  TZONE
//
//  Created by youssef on 3/18/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//

import Foundation
import UIKit

class Segue: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func goVC(_ vc : String)  {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func dismiss()  {
        navigationController?.popViewController(animated: true)
        
    }
    var activityindicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    func startanimating()  {
        activityindicator.center = view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityindicator)
        activityindicator.startAnimating()
    }
    
    func stopanimating()  {
        activityindicator.stopAnimating()
    }
    
}
