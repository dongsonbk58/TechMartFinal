//
//  Float.swift
//  FAC_IOS
//
//  Created by ThanhLong on 5/15/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation

extension Float {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()

    var delimiter: String {
        return Float.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
