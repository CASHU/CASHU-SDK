//
//  InitializationInterface.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/11/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class InitializationInterface: NSObject {
    
    class func initiateInInParent(_ parent : UIViewController){
        
        if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.shouldKeepLoginSession && UserIdentificationDataCenter.sharedInstance().cashuToken != nil && (UserIdentificationDataCenter.sharedInstance().cashuToken?.isValid())!){
            // go to payment directly
        }else{
            let storyboard = UIStoryboard(name: "Initialization", bundle: Bundle(for: InitializationViewController.self))
            let initializationViewController = storyboard.instantiateViewController(withIdentifier: "InitializationViewController") as! InitializationViewController
            if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .push){
                parent.navigationController?.pushViewController(initializationViewController, animated: true)
            }else if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .present){
                parent.present(initializationViewController, animated: true)
            }
        }
    }
}


