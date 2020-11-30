//
//  CASHUServices.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit
public class CASHUServices: NSObject {
    
    /**
     Initializing a new payment.
     
     - parameter parent: The parent which will hold the payment process.
     - parameter configurations: The configurations which will be used to hold some info like keys, options of display ..etc
     */
    public class func initiateProductPaymentInParent(_ parent : UIViewController, configurations : CASHUConfigurations){
        CASHURouter.initiateProductPaymentInParent(parent, configurations : configurations)
    }
    
    /**
     Initializing Testing Configurations, THIS FOR CASHU USE ONLY.
     
     - parameter parent: The parent which will hold the payment process.
     */
    public class func initiateTestingConfigurationsInParent(_ parent : UIViewController){
        CASHURouter.initiateTestingConfigurationsInParent(parent)
    }
}
