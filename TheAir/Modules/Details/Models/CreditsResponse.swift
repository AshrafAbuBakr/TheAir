//
//  CreditsResponse.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 03/12/2020.
//

import Foundation

import ObjectMapper

struct CreditsResponse: Mappable {
    
    var id: Int?
    var cast: [Cast]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        cast <- map["cast"]
    }
    
    
}

