//
//  LatestService.swift
//  TheAir
//
//  Created by Ashraf on 01/12/2020.
//

import Foundation

import Foundation
import Moya
import Alamofire

enum Services {
    case getGenres
    case getTopRated(pageNumber: Int)
    case getShowDetails(showID: Int)
    case getCredits(showID: Int)
}

extension Services: TargetType {
    
    var path: String {
        switch self {
        case .getTopRated(_):
            return "/tv/popular"
        case .getGenres:
            return "/genre/tv/list"
        case .getShowDetails(let showID):
            return "/tv/\(showID)"
        case .getCredits(let showID):
            return "/tv/\(showID)/credits"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getTopRated(_):
            return .get
        case .getGenres:
            return .get
        case .getShowDetails(_):
            return .get
        case .getCredits(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getTopRated(let pageNumber):
            let parameters: [String: Any] = ["api_key": API_KEY,
                                             "page": pageNumber]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getGenres:
            let parameters: [String: Any] = ["api_key": API_KEY]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getShowDetails(_):
            let parameters: [String: Any] = ["api_key": API_KEY]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .getCredits(_):
            let parameters: [String: Any] = ["api_key": API_KEY]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
