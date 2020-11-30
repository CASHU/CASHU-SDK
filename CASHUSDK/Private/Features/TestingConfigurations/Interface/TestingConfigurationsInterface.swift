//
//  TestingConfigurationsInterface.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/25/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class TestingConfigurationsInterface: NSObject {
    
    class func initiateInInParent(_ parent : UIViewController){
        let storyboard = UIStoryboard(name: "TestingConfigurations", bundle: Bundle(for: TestingConfigurationsSignInViewController.self))
        parent.present(storyboard.instantiateInitialViewController()!, animated: true)
    }
}
