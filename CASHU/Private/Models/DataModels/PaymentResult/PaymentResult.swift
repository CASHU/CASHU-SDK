//
//  PaymentResult.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/20/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class PaymentResult : NSObject {
    
    private(set) var transactionID = ""
    
    init(data:[String:AnyObject]) {
        super.init()
        
        transactionID = ValidationsUtility.forceObjectToBeString(data["mer_trn_id"])
    }
}
