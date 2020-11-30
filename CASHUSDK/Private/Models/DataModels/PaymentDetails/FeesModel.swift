//
//  FeesModel.swift
//  TestSDK
//
//  Created by Amr Saied on 10/5/20.
//

import Foundation
 
// MARK: - Welcome
class FeesModel: Codable {
    var key, nameAr, nameEn, value: String?

    enum CodingKeys: String, CodingKey {
        case key
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case value
    }
    init(){
        
    }
    init(key: String?, nameAr: String?, nameEn: String?, value: String?) {
        self.key = key
        self.nameAr = nameAr
        self.nameEn = nameEn
        self.value = value
    }
}
