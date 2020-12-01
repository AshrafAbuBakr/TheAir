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

enum TopRatedService {
    case getTopRated(pageNumber: Int)
}

extension TopRatedService: TargetType {
    
    var path: String {
        switch self {
        case .getTopRated(_):
            return "/tv/top_rated"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getTopRated(_):
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
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
