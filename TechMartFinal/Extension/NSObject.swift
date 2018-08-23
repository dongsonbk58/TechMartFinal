//
//  NSObject.swift
//
//  Created by Shohei Ohno on 2017/07/17.
//  Copyright © 2017年 s0hno. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        get {
            return NSStringFromClass(self).components(separatedBy: ".").last!
        }
    }

    var className: String {
        get {
            return String(describing: type(of: self))
        }
    }
}
