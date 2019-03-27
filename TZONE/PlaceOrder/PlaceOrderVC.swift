//
//  PlaceOrderVC.swift
//  TZONE
//
//  Created by lapstore on 12/26/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class PlaceOrderVC: UIViewController {
    @IBOutlet weak var ViewDriverDetails: UIView!
    
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var ViewSummary: UIView!

    var Jsondata = [String : Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ViewDriverDetails.applyShadow()
        self.ViewDriverDetails.roundCorners(cornerRadius: 10)
        self.ViewSummary.applyShadow()
        self.ViewSummary.roundCorners(cornerRadius: 10)
        
        self.ConfirmButton.roundCorners(cornerRadius: 20)

    }
    

    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func showFinish(_ sender: Any) {
        if Jsondata.count > 0{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "FinishVC") as? FinishVC{
                
                vc.allInformation = self.Jsondata
                
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    


}
