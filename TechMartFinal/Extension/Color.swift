//
//  Color.swift
//
//  Created by Dang Nguyen Vu on 7/20/17.
//  Copyright © 2017 s0hno. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func colorWithHexaCode(_ hexCode: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex = hexCode
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        guard hex.count == 6 else {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: hex).scanHexInt32(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: Color Constant
extension UIColor {
    var textColor: UIColor {
        return UIColor.colorWithHexaCode("ffffff")
    }
    class var borderViewColor: UIColor {
        return UIColor.colorWithHexaCode(ColorConstants.borderViewGreen)
    }
    
    class var darkGreenColor: UIColor {
        return UIColor.colorWithHexaCode(ColorConstants.darkGreen)
    }
    
    class var centerGreenColor: UIColor {
        return UIColor.colorWithHexaCode(ColorConstants.centerGreen)
    }
    
    class var lightGreenColor: UIColor {
        return UIColor.colorWithHexaCode(ColorConstants.lightGreen)
    }
}
