//
//  StringLocalizationExtension.swift
//  TheAir
//
//  Created by Ashraf on 30/11/2020.
//

import Foundation
import SwiftyUserDefaults

let ArabicLanguage: String = "ar"
let EnglishLanguage: String = "en"

extension String {
	func localizedString() -> String {
		let lang = Defaults.kSelectedLanguage
		
		if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
			let bundle = Bundle(path: path)
            let localizedValue = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
            return localizedValue
		} else {
			return self
		}
	}
    
    static func localizedNumberString(fromNumber number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = LanguageHandler.languageIsArabic() ? Locale(identifier: "ar_EG"): Locale(identifier: "en-US")
        let localeNumber = NSNumber(value: number)
        if let numberString = numberFormatter.string(from: localeNumber){
            return numberString
        }
        return ""
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailtest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailtest.evaluate(with: self)
    }
}
