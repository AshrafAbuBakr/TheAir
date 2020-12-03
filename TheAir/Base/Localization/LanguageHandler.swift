//
//  LanguageHandler.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 7/9/18.
//  Copyright © 2018 Ashraf Abu Bakr. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

enum ApplicationAvailableLanguages: String {
    case Arabic = "ar"
    case English = "en"
}

class LanguageHandler {
    
    class func currentLocale() -> Locale {
        if LanguageHandler.languageIsArabic() {
            return Locale(identifier: "ar_EG")
        } else {
            return Locale(identifier: "en_US")
        }
    }
    
    class func currentLanguageCode() -> String {
        if LanguageHandler.languageIsArabic() {
            return "ar"
        } else {
            return "en"
        }
    }
    
    class func languageIsArabic() -> Bool {
        return Defaults.kSelectedLanguage == ArabicLanguage ? true : false
    }
    
    class func getCurrentSemanticDirection() -> UISemanticContentAttribute {
        let direction: UISemanticContentAttribute = LanguageHandler.languageIsArabic() ? .forceRightToLeft:.forceLeftToRight
        return direction
        
    }
    
    class func getCurrentTextAlignment() -> NSTextAlignment {
        let alignment: NSTextAlignment = LanguageHandler.languageIsArabic() ? .right:.left
        return alignment
        
    }
    
    class func changeLanguage(language: ApplicationAvailableLanguages) {
        Defaults.kSelectedLanguage = language.rawValue
    }
    
    class func languagePrefix() -> String {
        return Defaults.kSelectedLanguage
    }
    
    class func updateLanguageToMatchDevice() {
        if let language = Locale.preferredLanguages.first {
            if let appLanguage = ApplicationAvailableLanguages(rawValue: language) {
                LanguageHandler.changeLanguage(language: appLanguage)
            } else {
                LanguageHandler.changeLanguage(language: .English)
            }
        }
    }
}
