//
//  Cast.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 03/12/2020.
//

import Foundation
import ObjectMapper

struct Cast: Mappable {
    
    var id: Int?
    var adult: Bool = false
    var gender: Int?
    var name: String?
    var profilePath: String?
    var character: String?
    var order: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        adult <- map["adult"]
        gender <- map["gender"]
        name <- map["name"]
        profilePath <- map["profile_path"]
        character <- map["character"]
        order <- map["order"]
    }
    
    
}
