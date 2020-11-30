//
//  PaymentDataCenter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/20/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class PaymentDataCenter: NSObject {
    
    private var doPaymentURL = "mobileSDK_Services/sdkDoPayment"
    private var paymentDetailsURL = "mobileSDK_Services/sdkPaymentDetails"
    
    fileprivate weak var delegate: OperationDelegate?
    
    private static var privateSharedInstance : PaymentDataCenter?
    private(set) var paymentResult: PaymentResult?
    private(set) var finalPaymentDetails: PaymentDetails?
    
    class func sharedInstance() -> PaymentDataCenter {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = PaymentDataCenter()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
    
    func getPaymentDetailsWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let parameters : [String:String] = ["LoginSession":UserIdentificationDataCenter.sharedInstance().accountInfo?.loginSession ?? "",
                                            "Env":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.environment == .dev ? "SAND" : "PROD",
                                            "SDK_Token":UserIdentificationDataCenter.sharedInstance().cashuSDKToken?.token ?? ""]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: paymentDetailsURL, requestMethod: .post, parameters: parameters, isShowLoading: false, aRequestID: .PaymentDetails, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
    
    func doPaymentWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let parameters : [String:String] = ["LoginSession":UserIdentificationDataCenter.sharedInstance().accountInfo?.loginSession ?? "",
                                            "Env":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.environment == .dev ? "SAND" : "PROD",
                                            "SDK_Token":UserIdentificationDataCenter.sharedInstance().cashuSDKToken?.token ?? ""]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: doPaymentURL, requestMethod: .post, parameters: parameters, isShowLoading: true, aRequestID: .CompletePayment, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
}


extension PaymentDataCenter : ConnectionRequestDelegate{
    
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data) {
        let response = ParsingUtility.parseDataAsDictionary(data)
        let cashuResponse : CASHUResponse = CASHUResponse(data: response)
        
        if(request.requestID == .CompletePayment){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.paymentResult = PaymentResult(data: cashuResponse.cashuBodyResponse.data)
            }
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }else if(request.requestID == .PaymentDetails){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.finalPaymentDetails = PaymentDetails(data: cashuResponse.cashuBodyResponse.data)
            }
            delegate?.didFinishOperation(request.requestID, object: cashuResponse)
        }
    }
    
    func requestDidRecieveError(request: ConnectionRequest, error: Error?) {
        delegate?.didRecieveErrorForOperation(request.requestID, andWithError: error)
    }
    
    func requestDidUploadWithProgress(_ uploadProgress: Float) {
        
    }
    
}
