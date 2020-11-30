//
//  ProductDetails.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit
open class ProductDetails: NSObject {
    
    // Currency for the payment, All transaction will be in USD, if other is selected transfer rates will be applied 
    open var currency : Currency = .usd
    
    // Product Price
    open var price = 0.0
    
    // Product Name
    open var productName = ""
    
    // Product Image
    open var productImage : UIImage?
    
    // Your session ID, this is totaly used by you
    open var sessionID : String = ""
    
    // The name of the service that the SDK is using
    open var serviceName : String = ""
    
    // Additional Object #1, this is totaly used by you
    // If you want to send any additional parameters and recieve it in the call back
    open var additionalObj1 : String = ""
    
    // Additional Object #2, this is totaly used by you
    open var additionalObj2 : String = ""
    
    // Additional Object #3, this is totaly used by you
    open var additionalObj3 : String = ""
    
    // Additional Object #4, this is totaly used by you
    open var additionalObj4 : String = ""
    
}
