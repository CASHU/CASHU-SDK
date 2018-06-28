//
//  CASHUConfigurationsCenter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation


class CASHUConfigurationsCenter: NSObject {
    
    private(set) var cashuConfigurations : CASHUConfigurations = CASHUConfigurations()
    
    private(set) var cashuTestingConfigurations : CASHUConfigurations?
    
    private static var privateSharedInstance : CASHUConfigurationsCenter?
    
    class func sharedInstance() -> CASHUConfigurationsCenter {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = CASHUConfigurationsCenter()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
    
    func setCASHUConfigurations(configurations : CASHUConfigurations){
        self.cashuConfigurations = configurations
        
        if let cashuTestingConfigurations = cashuTestingConfigurations{
            self.cashuConfigurations.clientID = cashuTestingConfigurations.clientID
            self.cashuConfigurations.language = cashuTestingConfigurations.language
            self.cashuConfigurations.environment = cashuTestingConfigurations.environment
            self.cashuConfigurations.cashuEnvironment = cashuTestingConfigurations.cashuEnvironment
            self.cashuConfigurations.productDetails.serviceName = cashuTestingConfigurations.productDetails.serviceName
            self.cashuConfigurations.productDetails.sessionID = cashuTestingConfigurations.productDetails.sessionID
        }
        
        switch self.cashuConfigurations.language{
        case .arabic:
            LocalizationManager.sharedInstance.changeCurrentLanguageTo(.arabic)
        case.english:
            LocalizationManager.sharedInstance.changeCurrentLanguageTo(.english)
        }
    }
    
    func setCASHUTestingConfigurations(testingConfigurations : CASHUConfigurations){
        self.cashuTestingConfigurations = testingConfigurations
    }
    
}
