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
    static let testingServiceURL = ""
    static let testingImagesURL = ""
    
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

}
