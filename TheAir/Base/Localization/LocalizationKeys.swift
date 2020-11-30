//
//  LocalizationKeys.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation

protocol LocalizableEnum {
    var localized: String { get }
}

extension LocalizableEnum where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localizedString()
    }
}
//MARK: - Error Messages -
class Localization {
    class Error {
        class var WrongLoginCredentials: String { return "WrongLoginCredentials".localizedString() }
        class var GeneralError: String { return "GeneralError".localizedString() }
        class var NetworkError: String { return "NetworkError".localizedString() }
    }
}

