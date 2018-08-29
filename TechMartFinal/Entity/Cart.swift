//
//  Cart.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

class Cart: NSObject {
    var product: Product?
    var count: Int = 0
    
    init(product: Product, count: Int) {
        self.product = product
        self.count = count
    }
}
