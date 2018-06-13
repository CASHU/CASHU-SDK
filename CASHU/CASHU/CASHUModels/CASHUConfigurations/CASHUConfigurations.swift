//
//  CASHUConfigurations.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

open class CASHUConfigurations: NSObject {
    
    // How to do you want to display the service
    open var presentingMethod : PresentingMethod = .push
    
    // Key which is provided by cashu for you
    open var key : String = ""
    
    // Your username which is associated with the key
    open var userName : String = ""
    
    // choose one of our supported languages
    open var language : ContentLanguge = .english
    
    // enable logging
    open var isLoggingEnabled : Bool = true
    
    // Determine wehter the user login session should be kept until the hardclose or everytime the user should login again
    open var shouldKeepLoginSession = true
}
