//
//  ProductListTableViewCell.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

protocol ProductListTableViewCellDelegate : NSObjectProtocol {
    func didTapOnPaymentButtonForCellWithIndex(cellIndex : Int)
}

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var productImageView : UIImageView!
    @IBOutlet weak var paymentButton : UIButton!
    
    var cellIndex = 0
    weak var delegate : ProductListTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func pay(_ sender: Any) {
        self.delegate?.didTapOnPaymentButtonForCellWithIndex(cellIndex: cellIndex)
    }
}

