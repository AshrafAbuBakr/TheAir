//
//  ParsingManager.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import ObjectMapper

class ParsingHandler: NSObject {
    
    class func parseObject<T: Mappable>(responseData: Data, toModel model:T.Type) -> T? {
        let responseString: String = String(data: responseData, encoding: .utf8)!
        
        if let responseObject = Mapper<T>().map(JSONString: responseString) {
            return responseObject
        }
        return nil
    }
    
    class func parseArray<T: Mappable>(responseData: Data, toModel model:T.Type) -> [T]? {
        let responseString: String = String(data: responseData, encoding: .utf8)!
        
        if let responseArray = Mapper<T>().mapArray(JSONString: responseString) {
            return responseArray
        }
        return nil
    }

    class func isNull(responseData: Data) -> Bool {
        let responseString = String(data: responseData, encoding: .utf8)
        
        if responseString == nil || responseString == "" || responseString == "null" {
            return true
        }
        return false
    }
    
}
