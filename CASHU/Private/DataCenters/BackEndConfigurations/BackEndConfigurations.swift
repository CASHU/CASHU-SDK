//
//  BackEndConfigurations.swift
//
//  Created by Ahmed AbdEl-Samie on 9/28/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation

enum Server {
    case testing
    
    static func getCurrentServer() -> Server{
        return .testing
    }
}

class BackEndConfigurations: NSObject {
    private static let testingServiceURL = "https://api.cashu.com/v1.0/rest/"
    private static let testingImagesURL = "https://api.cashu.com/v1.0/rest/"
    private static let testingCASHU_SECRET_KEY = "mW7tMQFu"
    private static let ENCRYPTION_KEY = "O0@jk12sdj@!#dsZl12$3ed12Q024Sa#dasdsffsd%gdfssdfs214!@A"
    private static let ENCRYPTION_IV = "12345678"
    private static let STORE_ENCRYPTION_KEY = "K"+"WED23324sERVF"+"w"+"WED23324sERVF"+"P"+"WED23324sERVF"+"x"+"WED23324sERVF"
    private static let STORE_ENCRYPTION_IV = "36472093"
    
    
    class func getServiceURL() -> String{
        switch Server.getCurrentServer() {
        case .testing:
            return testingServiceURL
        }
    }
    
    class func getImagesURL() -> String{
        switch Server.getCurrentServer() {
        case .testing:
            return testingImagesURL
        }
    }
    
    class func secretKey() -> String{
        switch Server.getCurrentServer() {
        case .testing:
            return testingCASHU_SECRET_KEY
        }
    }
    
    class func testingEncKey() -> String{
        return ENCRYPTION_KEY
    }
    
    class func testingEncIV() -> String{
        return ENCRYPTION_IV
    }
    
    class func productionEncKey() -> String{
        return STORE_ENCRYPTION_KEY
    }
    
    class func productionEncIV() -> String{
        return STORE_ENCRYPTION_IV
    }
    

}
