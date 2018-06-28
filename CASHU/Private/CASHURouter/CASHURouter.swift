//
//  CASHURouter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

public enum PresentingMethod {
    case present
    case push
}

public enum ContentLanguge {
    case english
    case arabic
}

public enum Environment {
    case prod
    case dev
}

public enum Currency {
    case usd
    case aed
}

enum CASHU_Environment {
    case prod
    case uat
}

public protocol CASHUServicesDelegate {
    func didFinishPaymentSuccessfullyWithReferenceID(referenceID : String, productDetails : ProductDetails)
    func didFailPaymentWithReferenceID(referenceID : String, productDetails : ProductDetails)
}


class CASHURouter: NSObject {
    
    class func initiateProductPaymentInParent(_ parent : UIViewController, configurations : CASHUConfigurations){
        CASHUConfigurationsCenter.sharedInstance().setCASHUConfigurations(configurations: configurations)
        InitializationInterface.initiateInInParent(parent)
    }
    
    class func initiateTestingConfigurationsInParent(_ parent : UIViewController){
        TestingConfigurationsInterface.initiateInInParent(parent)
    }
}

