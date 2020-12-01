//
//  ErrorHandler.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import UIKit
import Moya

enum AirErrorCode: Int {
    case networkError = 123456
    case wrongLoginCredentials  = 400
    case generalError = 4000
}

struct AirError: Error {
    var errorCode: AirErrorCode = .generalError
    var serverErrorCode: Int?
    var errorMessage: String {
        return ErrorHandler.errorMesage(forErrorCode: errorCode)
    }
}

class ErrorHandler {
    
    class func errorMesage(forErrorCode error: AirErrorCode) -> String {
        switch error {
        case .networkError:
            return Localization.Error.NetworkError
        case .wrongLoginCredentials:
            return Localization.Error.WrongLoginCredentials
        default:
            return Localization.Error.GeneralError
        }
    }
}
