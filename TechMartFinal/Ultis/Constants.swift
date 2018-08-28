//
//  Constants.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit
struct StringConstants {
    static let appName = "Tech Mart"
}

struct NumberConstants {
    static let passcodeDigitNumber = 6
    static let cornerCGFloat: CGFloat = 5
    static let otpStatusCode = 210
    static let successStatusCode = 200
    static let expiredTokenStatusCode = 401
}

extension Notification.Name {
    static let changeTab = Notification.Name(rawValue: "changeTabNotification")
}
