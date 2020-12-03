//
//  DetailsResponse.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 02/12/2020.
//

import Foundation
import ObjectMapper

struct DetailsResponse: Mappable {
    var backdropPath: String?
    var genres: [Genre]?
    var numberOfEpisodes: Int?
    var networks: [Network]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        backdropPath <- map["backdrop_path"]
        genres <- map["genres"]
        numberOfEpisodes <- map["number_of_episodes"]
        networks <- map["networks"]
    }
}
