//
//  UserDefaultsConstants.swift
//  TheAir
//
//  Created by Ashraf Abu Bakr on 6/15/18.
//  Copyright © 2018 Ashraf Abu Bakr. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var kSelectedLanguage: DefaultsKey<String> { .init("SelectedLanguage", defaultValue: "en") }
}
