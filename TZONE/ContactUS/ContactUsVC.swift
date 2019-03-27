//
//  ContactUsVC.swift
//  TZONE
//
//  Created by lapstore on 12/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit

class ContactUsVC: UIViewController {
    @IBOutlet weak var SendMessage: UIButton!
    
    @IBOutlet weak var ViewContainFields: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ViewContainFields.applyShadow()
        self.ViewContainFields.roundCorners(cornerRadius: 10)
        self.SendMessage.roundCorners(cornerRadius: 20)

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
