//
//  CachingMoyaPlugin.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import Moya

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension CachePolicyGettable  where Self: TargetType {
    var cachePolicy: URLRequest.CachePolicy {
        switch self.method {
        case .get:
            return .returnCacheDataElseLoad
        default:
            return .reloadIgnoringLocalCacheData
        }
    }
    
}

final class NetworkDataCachingPlugin: PluginType {
    
    init (configuration: URLSessionConfiguration, inMemoryCapacity: Int, diskCapacity: Int, diskPath: String?) {
        configuration.urlCache = URLCache(memoryCapacity: inMemoryCapacity, diskCapacity: diskCapacity, diskPath: diskPath)
    }
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cacheableTarget = target as? CachePolicyGettable {
            var mutableRequest = request
            if Connectivity.shared.isConnectedToInternet() {
                mutableRequest.cachePolicy = .reloadIgnoringCacheData
            } else {
                mutableRequest.cachePolicy = cacheableTarget.cachePolicy
            }
            return mutableRequest
        }
        return request
    }
}
