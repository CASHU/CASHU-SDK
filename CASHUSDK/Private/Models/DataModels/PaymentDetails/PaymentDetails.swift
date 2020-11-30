//
//  PaymentDetails.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation

class PaymentDetails : NSObject {
    
    private(set) var currency = ""
    private(set) var amount = ""
    private(set) var displayText = ""
    
    public static var totalAmount = ""

    
    private(set) var convertedCurrency = ""
    private(set) var convertedAmount = ""
    
    public static var feesModelList : [FeesModel] = []
    init(data:[String:AnyObject]) {
        super.init()
        
        if let payObjectData = data["Pay_Obj"] as? String{
            let payObject = payObjectData.data(using: .utf8)!
            let data = ParsingUtility.parseDataAsDictionary(payObject)
            currency = ValidationsUtility.forceObjectToBeString(data["currency"])
 
            amount = ValidationsUtility.forceObjectToBeString(data["amount"])
            displayText = ValidationsUtility.forceObjectToBeString(data["displayText"])
        }
        
        if let Fees_ObjData = data["Fees_Obj"] as? [[String:AnyObject]]{
            PaymentDetails.feesModelList = []
            Fees_ObjData.forEach { (data2) in
                var feesModel = FeesModel(key: ValidationsUtility.forceObjectToBeString(data2["key"]), nameAr: ValidationsUtility.forceObjectToBeString(data2["name_ar"]), nameEn: ValidationsUtility.forceObjectToBeString(data2["name_en"]), value: ValidationsUtility.forceObjectToBeString(data2["value"]))
                PaymentDetails.feesModelList.append(feesModel)

                
            }
            PaymentDetails.totalAmount = ValidationsUtility.forceObjectToBeString(data["TotalAmount"])
            PaymentDetails.feesModelList =   PaymentDetails.feesModelList
            UserIdentificationDataCenter.sharedInstance().paymentDetails
//            currency = ValidationsUtility.forceObjectToBeString(data["currency"])
//            amount = ValidationsUtility.forceObjectToBeString(data["amount"])
//            displayText = ValidationsUtility.forceObjectToBeString(data["displayText"])
        }
        
        
        
        
        if let convertedAmountData = data["Converted_Obj"] as? String{
            let convertedAmountD = convertedAmountData.data(using: .utf8)!
            let data = ParsingUtility.parseDataAsDictionary(convertedAmountD)
            convertedCurrency = ValidationsUtility.forceObjectToBeString(data["currency"])
            convertedAmount = ValidationsUtility.forceObjectToBeString(data["amount"])
        }
    }
}

func parseStringToObject<T: Codable>(from data: String) -> T{
    if let data = data.data(using: .utf8) {
         let decoder = JSONDecoder()
               do {
                  let obj = try decoder.decode(T.self, from: data)
                  return obj
               } catch let DecodingError.dataCorrupted(context) {
                   print(context)
               } catch let DecodingError.keyNotFound(key, context) {
                   print("Key '\(key)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch let DecodingError.valueNotFound(value, context) {
                   print("Value '\(value)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch let DecodingError.typeMismatch(type, context)  {
                   print("Type '\(type)' mismatch:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch {
                   print("error: ", error)
               }
    }
    
    
   
    return () as! T
}
func parseObject<T: Codable>(from data: Data) -> T? {
    let decoder = JSONDecoder()
    do {
       let obj = try decoder.decode(T.self, from: data)
       return obj
    } catch let DecodingError.dataCorrupted(context) {
        print(context)
    } catch let DecodingError.keyNotFound(key, context) {
        print("Key '\(key)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
        print("Value '\(value)' not found:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context)  {
        print("Type '\(type)' mismatch:", context.debugDescription)
        print("codingPath:", context.codingPath)
    } catch {
        print("error: ", error)
    }
    return nil
}
func getObject<T: Codable>(from dict: NSDictionary) -> T? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
        return parseObject(from: jsonData)
    }
    
    print("Error Dictionary String To Data")
    return nil
}
