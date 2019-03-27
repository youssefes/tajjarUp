//
//  NotificationVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var ViewContainCar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ViewContainCar.layer.borderWidth = 2.0
        ViewContainCar.layer.borderColor = UIColor(red: 3/255, green: 169/255, blue: 244/255, alpha: 1.0).cgColor
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
}
