//
//  Genre.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import Foundation
import ObjectMapper

struct Genre: Mappable {
    
    var id: Int?
    var name: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

extension Genre: Equatable {
    public static func != (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
