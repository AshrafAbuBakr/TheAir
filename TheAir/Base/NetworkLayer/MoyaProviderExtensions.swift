//
//  MoyaProviderExtensions.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import Moya
import KeychainAccess
//import SwiftyUserDefaults

extension TargetType {
    
    var baseURL: URL {
        if let url = URL(string: BASE_URL) {
            return url
        }
        fatalError("BASE URL NOT FOUND")
    }
    
    func defaultHeaders() -> [String: String]? {
        var headerDict: [String: String] = [:]
        return headerDict
    }
    
    func defaultHeadersWithJsonContent() -> [String: String]? {
        var headers = defaultHeaders()
        headers?["Content-Type"] = "application/json"
        return headers
    }
    
    var headers: [String: String]? {
        return defaultHeaders()
    }
    
}

