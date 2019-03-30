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
   
    @IBOutlet weak var creditBtn: UIButton!
    @IBOutlet weak var k_netBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    
    @IBOutlet weak var containerWeb: UIView!
    @IBOutlet weak var ConfirmButton: UIButton!
    @IBOutlet weak var ViewSummary: UIView!

    @IBOutlet weak var RadioButton : UIButton!
    var order = ""
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
        cashBtn.setImage(UIImage(named:"Ellipse1"), for: .selected)
        k_netBtn.setImage(UIImage(named:"Ellipse1"), for: .selected)
        creditBtn.setImage(UIImage(named:"Ellipse1"), for: .selected)

    }
    
    func animationCheckBtn(sender : UIButton){
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    

    @IBAction func checkBoxBtn(_ sender : UIButton){
        animationCheckBtn(sender: sender)
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
    

    @IBAction func K_net(_ sender: UIButton) {
        animationCheckBtn(sender: sender)
        creditBtn.isSelected = false
        cashBtn.isSelected = false
        if self.containerWeb.isHidden == true{
            self.containerWeb.isHidden = false
        }
    }
    
    @IBAction func creditCard(_ sender: UIButton) {
        animationCheckBtn(sender: sender)
        cashBtn.isSelected = false
        k_netBtn.isSelected = false
        if self.containerWeb.isHidden == true{
            self.containerWeb.isHidden = false
        }
    }
    
    @IBAction func cashBtn(_ sender: UIButton) {
        k_netBtn.isSelected = false
        creditBtn.isSelected = false
        animationCheckBtn(sender: sender)
        self.containerWeb.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is WebViewPay
        {
            let vc = segue.destination as? WebViewPay
            vc?.orderId = order
        }
    }
    
}
