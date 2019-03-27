//
//  TermsVC.swift
//  TZONE
//
//  Created by lapstore on 12/25/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TermsVC: Segue {
    var titlearray : [String]  = []
    var detailsarray : [String] = []
    let url = Globals.Terms
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.tableFooterView = UIView()
         tableview.separatorInset = .zero
        tableview.contentInset = .zero
        tableview.dataSource = self
        tableview.delegate = self
     Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
        .responseJSON { response in
            switch response.result {
            case .failure(let error):
                print(error)
                
            case .success(let value):
                let json = JSON(value)
                
                var title = json["Title"].string!
                    self.titlearray.append(title)
                print(title)
                    
                    var details = json["Details"].string!
                    self.detailsarray.append(details)
                print(details)
                self.tableview.reloadData()
                    
                }
        }
    
        
}

    @IBAction func dismissbtn(_ sender: Any) {
        
        dismiss()
    }
}
extension TermsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  detailsarray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermsCell", for: indexPath) as! TermsCell
       cell.titlelbl.text = titlearray[indexPath.row]
        cell.termslbl.text = detailsarray[indexPath.row]
        
    
        
        return cell
    }
    
    
}
    
    
    
    
    

