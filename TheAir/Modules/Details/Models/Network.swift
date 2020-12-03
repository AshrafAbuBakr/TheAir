//
//  Network.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 03/12/2020.
//

import Foundation
import ObjectMapper

struct Network: Mappable {
    
    var name: String?
    var id: Int?
    var logoPath: String?
    var originCountry: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        logoPath <- map["logo_path"]
        originCountry <- map["origin_country"]
    }
    
    
}
