//
//  TopRatedResult.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 01/12/2020.
//

import Foundation
import ObjectMapper
import RealmSwift

class TopRatedResult: Object, Mappable {
    
     @objc dynamic var posterPath: String?
     @objc dynamic var name: String?
     @objc dynamic var id: Int = 0
     @objc dynamic var voteAverage: Float = 0.0
     @objc dynamic var firstAirDate: String?
     @objc dynamic var overview: String?
    
    required init?(map: Map) {
        
    }
    
    override init() {
        
    }
    
    func mapping(map: Map) {
        posterPath <- map["poster_path"]
        name <- map["name"]
        id <- map["id"]
        voteAverage <- map["vote_average"]
        firstAirDate <- map["first_air_date"]
        overview <- map["overview"]
    }
}
