//
//  InitializationViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/11/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class InitializationViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var messageLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(IPUtility.sharedInstance().ipAddress == ""){
            IPUtility.sharedInstance().getIPAddressWithDelegate(self)
        }else{
            UserIdentificationDataCenter.sharedInstance().authenticateWithDelegate(self)
        }
        
        self.messageLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("InitializationInitialMessage")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}

extension InitializationViewController : OperationDelegate{
    
    func didFinishOperation(_ operationID: OperationID) {
        if(operationID == .IPAddressInfo){
            UserIdentificationDataCenter.sharedInstance().authenticateWithDelegate(self)
        }
    }
    
    func didFinishOperation(_ operationID: OperationID, object: AnyObject) {
        if(operationID == .Authenticate){
            if let cashuResponse = object as? CASHUResponse {
                if(cashuResponse.cashuBodyResponse.resultCode != "200"){
                    self.activityIndicator.stopAnimating()
                    switch CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.language{
                    case .arabic:
                        self.messageLabel.text = cashuResponse.cashuBodyResponse.resultMessageAr
                    case.english:
                        self.messageLabel.text = cashuResponse.cashuBodyResponse.resultMessageEn
                    }
                    
                    self.messageLabel.textColor = .red
                    
                    if CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.isLoggingEnabled {
                        NSLog("***!!!*** CASHU Error : ***!!!*** \n\(cashuResponse.cashuBodyResponse.resultMessageError)")
                    }
                }
            }
        }
    }
    
    func didRecieveErrorForOperation(_ operationID: OperationID, andWithError error: Error?) {
        
    }
    
    func didCancelOperation(_ operationID: OperationID) {
        
    }
}
