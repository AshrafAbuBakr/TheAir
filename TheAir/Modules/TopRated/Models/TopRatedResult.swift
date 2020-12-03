//
//  TopRatedResult.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 01/12/2020.
//

import Foundation
import ObjectMapper

struct TopRatedResult: Mappable {
    
    var posterPath: String?
    var name: String?
    var id: Int?
    var voteAverage: Float = 0.0
    var popularity: Float?
    var voteCount: Int?
    var firstAirDate: String?
    var originalName: String?
    var backdropPath: String?
    var genreIds: [Int]?
    var originCountry: [String]?
    var originalLanguage: String?
    var overview: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        posterPath <- map["poster_path"]
        name <- map["name"]
        id <- map["id"]
        voteAverage <- map["vote_average"]
        popularity <- map["popularity"]
        voteCount <- map["vote_count"]
        firstAirDate <- map["first_air_date"]
        originalName <- map["original_name"]
        backdropPath <- map["backdrop_path"]
        genreIds <- map["genre_ids"]
        originCountry <- map["origin_country"]
        originalLanguage <- map["original_language"]
        overview <- map["overview"]
    }
}
