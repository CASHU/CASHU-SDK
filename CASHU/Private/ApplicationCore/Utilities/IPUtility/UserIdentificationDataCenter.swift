//
//  UserIdentificationDataCenter.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/13/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class UserIdentificationDataCenter: NSObject {
    
    private var authenticationURL = "common/authenticate"
    
    fileprivate weak var delegate: OperationDelegate?

    private static var privateSharedInstance : UserIdentificationDataCenter?
    private(set) var cashuToken: CASHUToken?
    
    class func sharedInstance() -> UserIdentificationDataCenter {
        guard let sharedInstance = privateSharedInstance else {
            privateSharedInstance = UserIdentificationDataCenter()
            return privateSharedInstance!
        }
        
        return sharedInstance
    }
    
    class func destroy() {
        privateSharedInstance = nil
    }
    
    func authenticateWithDelegate(_ delegate: OperationDelegate?){
        self.delegate = delegate
        
        let parameters : [String:String] = ["Area":"ios",
                                            "AreaVersion":"1.01",
                                            "Key":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.key,
                                            "Username":CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.userName]
        
        let cr : ConnectionRequest = ConnectionRequest(delegate: self, requestURL: authenticationURL, requestMethod: .post, parameters: parameters, isShowLoading: false, aRequestID: .Authenticate, isACoreRequest: false)
        cr.isFollowingCASHUStructure = true
        cr.initiateRequest()
    }
}


extension UserIdentificationDataCenter : ConnectionRequestDelegate{
    
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data) {
        let response = ParsingUtility.parseDataAsDictionary(data)
        let cashuResponse : CASHUResponse = CASHUResponse(data: response)
        
        if(request.requestID == .Authenticate){
            if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                self.cashuToken = CASHUToken(data: cashuResponse.cashuBodyResponse.data)
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
