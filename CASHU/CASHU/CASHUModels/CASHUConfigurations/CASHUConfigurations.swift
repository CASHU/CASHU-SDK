//
//  CASHUConfigurations.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

public class CASHUConfigurations: NSObject {
    
    // Client ID provided to your from cashu
    public var clientID = ""
    
    // UNIQUE Merchant Reference 
    public var merchantReference = ""
    
    // Prefered enviornment to run the sdk on it
    public var environment : Environment = .dev
    
    
    // Product details which will be used through the payment process
    public var productDetails : ProductDetails = ProductDetails()
    
    // How to do you want to display the service
    public var presentingMethod : PresentingMethod = .push
    
    // SDK Token provided to you from cash u
    public var sdkToken = ""
    
    // choose one of our supported languages
    public var language : ContentLanguge = .english
    
    // enable logging
    public var isLoggingEnabled : Bool = true
    
    // Delegate which will be notified when the transaction is completed successfully or failed
    public var delegate : CASHUServicesDelegate?
    
    // For TESTING PURPOSES ONLY, DON'T CHANGE
    var cashuEnvironment : CASHU_Environment = .prod
    
}
