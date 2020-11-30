//
//  PaymentMethodsTableViewCell.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/7/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var paymentMethodLabel : UILabel!
    @IBOutlet weak var paymentMethodImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

