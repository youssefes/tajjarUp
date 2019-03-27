//
//  CarDetailsOrCarListCell.swift
//  TZONE
//
//  Created by lapstore on 7/24/18.
//  Copyright © 2018 AmrSobhy. All rights reserved.
//

import UIKit
import DLRadioButton

class CarDetailsOrCarListCell: UICollectionViewCell {
    
    @IBOutlet weak var CarBags: UILabel!
    @IBOutlet weak var Group: UILabel!
    @IBOutlet weak var Power_motor: UILabel!
    @IBOutlet weak var type_motor: UILabel!
    @IBOutlet weak var Diesel: UILabel!
//    @IBOutlet weak var ContainView: UIView!
    @IBOutlet weak var CarName: UILabel!
    
    @IBOutlet weak var GreatDeal: UILabel!
    
    @IBOutlet weak var ViewDetails: UIView!
    
    @IBOutlet weak var PayApickUp: UILabel!
    
    @IBOutlet weak var UnLimited: UILabel!
    
    @IBOutlet weak var PriceByDay: UILabel!
    @IBOutlet weak var Price_offer: UILabel!
    @IBOutlet weak var CarImage: UIImageView!
    @IBOutlet weak var FreeCancellation: UILabel!
    override func awakeFromNib() {
//        self.ContainView.applyShadow()
//        self.ContainView.layer.cornerRadius = 10
    }
}
