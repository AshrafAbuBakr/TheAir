//
//  RequestManager.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import Moya
import ObjectMapper

typealias RequestCompletionHandler = (Any?, AirError?) -> ()

class RequestManager {
    
    class func beginRequest<T: Mappable, ProvidertType: TargetType>(withTargetType targetType: ProvidertType.Type,
                                                                           andTarget target: ProvidertType,
                                                                           responseModel model: T.Type,
                                                                           andHandler handler: @escaping RequestCompletionHandler) {
        let provider = MoyaProvider<ProvidertType>()
        provider.request(target) { (result) in
            switch result {
            case let .success(moyaResponse):
                guard moyaResponse.statusCode >= 200 && moyaResponse.statusCode < 300 else {
                    var error: AirError = AirError(errorCode: .generalError , serverErrorCode: moyaResponse.statusCode)
                    if let code = AirErrorCode(rawValue: moyaResponse.statusCode) {
                        error.errorCode = code
                    }
                    handler(nil, error)
                    return
                }
                
                if let parsedObject = ParsingHandler.parseObject(responseData: moyaResponse.data, toModel: model) {
                    handler(parsedObject, nil)
                } else if let parsedArray = ParsingHandler.parseArray(responseData: moyaResponse.data, toModel: model) {
                    handler(parsedArray, nil)
                } else if ParsingHandler.isNull(responseData: moyaResponse.data) {
                    handler(nil, nil)
                } else {
                    let error: AirError = AirError(errorCode: .generalError, serverErrorCode: nil)
                    handler(nil, error)
                }
                break
            case let .failure(error):
                print(error.localizedDescription)
                let winjiError: AirError = AirError(errorCode: .generalError, serverErrorCode: error.errorCode)
                handler(nil, winjiError)
                break
            }
        }
    }
}
