//
//  UIColor+Ext.swift
//  Knot
//
//  Created by truong.tuan.quang on 1/18/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255
        let b = CGFloat((hex & 0x0000ff)) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat(red) / 255
        let g = CGFloat(green) / 255
        let b = CGFloat(blue) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(white: Int, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(white) / 255.0, alpha: alpha)
    }
}
