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

    @IBOutlet weak var RadioButton : UIButton!
    
    var Jsondata = [String : Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ViewDriverDetails.applyShadow()
        self.ViewDriverDetails.roundCorners(cornerRadius: 10)
        self.ViewSummary.applyShadow()
        self.ViewSummary.roundCorners(cornerRadius: 10)
        
        self.ConfirmButton.roundCorners(cornerRadius: 20)
        
        RadioButton.setImage(UIImage(named:"Ellipse1"), for: .selected)

    }
    

    @IBAction func checkBoxBtn(_ sender : UIButton){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
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
