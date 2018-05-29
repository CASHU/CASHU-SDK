//
//  ConnectionRequest.swift
//  
//
//  Created by Ahmed Abd El-Samie on 5/20/17.
//  Copyright © 2017 Ahmed AbdEl-Samie. All rights reserved.
//

import Foundation

/**
 Request supported http method.
 
 - get: Get Method.
 - post: Post Method.
 - delete: Delete Method.
 - put: Put Method.
 */
enum ConnectionRequestHTTPMethod : Int {
    case get
    case post
    case delete
    case put
}

/**
 Connection Request delegate that will be notified when the request is completed successfully or failed with error.
 */
protocol ConnectionRequestDelegate: NSObjectProtocol {
    /**
     Notify the delegate that the request did complete successfully.
     It will pass the data from the response.
     
     - parameter request: The request itself
     - parameter data: The data from the request response
     */
    func requestDidCompleteLoading(request: ConnectionRequest, data: Data)
    /**
     Notify the delegate that the request did fail.
     It will pass the error from the response.
     
     - parameter request: The request itself
     - parameter error: The error from the request response
     */
    func requestDidRecieveError(request: ConnectionRequest, error: Error?)
    
    func requestDidUploadWithProgress(_ uploadProgress : Float)
}

/**
 Connection Request is the main gateway for any request in the application.
 It contains different sets and options for any request.
 It uses the connection manager to handle the request
 */
class ConnectionRequest: NSObject {
    var isUploadRequest : Bool = false
    
    // is the URL complete, we don't need to appened the service url to it
    var isCompleteURL: Bool = false
    // show loading view when executing the reques
    private(set) var isShowLoading: Bool = false
    // is the request is core and coudn'lt be canceled until it's completed
    // Reviser the ConnectionManager class for more info
    private(set) var isCoreRequest: Bool = false
    
    public var object: Any?
    // Delegate to be notified when the request is completed or failed
    private weak var delegate: ConnectionRequestDelegate?
    // Request http Method
    private var requestMethod = ConnectionRequestHTTPMethod.get
    // Request URL as string
    private var requestURL: String = ""
    // Request to be passed to the session
    private(set) var request: URLRequest?
    // Data from the request
    var data: Data?
    // Parameters of the request
    private var parameters : [String: Any]? = [String: Any]()
    
    // request ID, it will be mainly from the operation ids enum
    private(set) var requestID : OperationID = .None
    // to be update when the request is canceled
    var isRequestCanceled: Bool = false

    /**
     Initializing a new connection request with the provided info.
     
     - parameter delegate: Delegate to be notified when the reques is completed or failed
     - parameter requestURL: The request URL without the service URL
     - parameter requestMethod: The http method for the request - use the ConnectionRequestHTTPMethod enum
     - parameter parameters: The parameters of the request
     - parameter isShowLoading: Show loading while executing the request or not
     - parameter aRequestID: A Unique ID for the request, use the OperationID enum
     - parameter isACoreRequest: Is this a core request and must be executed no matter what, the user can't cancel it even if there is a data connection error, It will be a blocking until it's done
     
     - returns: Initialized Object with the provided info.
     */
    init(delegate: ConnectionRequestDelegate?, requestURL: String, requestMethod: ConnectionRequestHTTPMethod, parameters: [String: Any]?, isShowLoading: Bool, aRequestID: OperationID, isACoreRequest: Bool) {
        super.init()
        self.delegate = delegate
        self.requestURL = requestURL
        self.requestMethod = requestMethod
        isRequestCanceled = false
        data = Data()
        self.parameters = parameters
        self.isShowLoading = isShowLoading
        isCompleteURL = false
        isCoreRequest = isACoreRequest
        requestID = aRequestID
    }

    /**
     Setups and run the request.
     */
    func initiateRequest() {
        if(!isUploadRequest){
            setUp()
        }else{
            ConnectionManager.sharedInstance.addVIRequest(self)
            return
        }
        ConnectionManager.sharedInstance.add(self)
    }
    
    /**
     Cancels the request.
     */
    func cancel() {
        ConnectionManager.sharedInstance.cancel(self)
    }

    /**
     Connection Manager did receive an error for this request.
     Notifying the delegate.
     
     - parameter error: The error from the response
     */
    func connectionManagerDidRecieveError(_ error: Error?) {
        if delegate != nil {
            delegate?.requestDidRecieveError(request: self,error: error)
        }
    }

    /**
     Connection Manager did complete loading data for this request.
     Notifying the delegate.
     */
    func connectionManagerDidCompleteLoadingData() {
        if delegate != nil {
            delegate?.requestDidCompleteLoading(request: self,data: data!)
        }
    }
    
    
    func connectionManagerDidUploadWithProgress(_ uploadProgress : Float){
        if delegate != nil {
            delegate?.requestDidUploadWithProgress(uploadProgress)
        }
    }

    /**
     private method to setup the URL with the data provided during intialization.
     
     - returns: Initialized URL.
     */
    private func setUpURL() -> URL {
        var urlString: String = ""
        var andString: String = ""
        var isFirstKeyAdded: Bool = false
        // If the request URL is complete URL then we don't need to appened the service url from the configurations manager
        if isCompleteURL {
            urlString = requestURL
        }
        else {
            urlString = "\(BackEndConfigurations.getServiceURL())\(requestURL)"
        }
        
        // if the request method is get then we need to appened the parameters into the url itself
        if requestMethod == .get {
            if parameters != nil && (parameters?.count)! > 0 {
                urlString = "\(urlString)?"
            }
            
            if(parameters != nil){
                for key: String in (parameters?.keys)! {
                    andString = isFirstKeyAdded ? "&" : ""
                    urlString = "\(urlString)\(andString)\(key)=\((parameters?[key])!)"
                    isFirstKeyAdded = true
                }
            }
        }
        return URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
    }

    /**
     private method to setup the body of the request with the data provided during intialization.
     
     - returns: Initialized Data Object for the request body.
     */
    private func setUpBody() -> Data {
        if parameters == nil {
            parameters = [String: String]()
        }
        // Append the parameters as JSON
        let bodyData: Data? = try? JSONSerialization.data(withJSONObject: parameters!, options: [])
        return bodyData!
    }

    /**
     Private method to setup headers of the request.
     It only supports for now application/json only
     TODO : Make it dynamic
     */
    private func setUpHeaders() {
        request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    /**
     Private method to setup the request headers and body and url with the data provided during intialization.
     */
    private func setUp() {
        request = URLRequest(url: setUpURL())
        if requestMethod == .get {
            request?.httpMethod = "GET"
        }
        else if requestMethod == .post {
            request?.httpMethod = "POST"
            setUpHeaders()
            request?.httpBody = setUpBody()
        }
        else if requestMethod == .delete {
            request?.httpMethod = "DELETE"
            setUpHeaders()
            request?.httpBody = setUpBody()
        }
        else if requestMethod == .put {
            request?.httpMethod = "PUT"
            setUpHeaders()
            request?.httpBody = setUpBody()
        }

    }
    
}
