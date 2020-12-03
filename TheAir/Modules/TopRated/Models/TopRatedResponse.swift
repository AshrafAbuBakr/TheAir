//
//  TopRatedResponse.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 01/12/2020.
//

import Foundation
import ObjectMapper



struct TopRatedResponse: Mappable {
    
    var page: Int?
    var totalPages: Int?
    var results: [TopRatedResult]?
    var totalResults: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        totalPages <- map["total_pages"]
        results <- map["results"]
        totalResults <- map["total_results"]
    }
}
