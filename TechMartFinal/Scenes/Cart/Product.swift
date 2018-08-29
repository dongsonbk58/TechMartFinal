//
//  Product.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

class Product: BaseModel {
    
    var id: Int = 0
    var title: String = ""
    var description: String = ""
    var numberFavorite: Int = 0
    var sale: Int = 0
    var categoryId: Int = 0
    var barCode: String = ""
    var sellId: Int = 0
    var price: Int = 0
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        
    }
    
    init(id: Int, title: String, price: Int, description: String, numberFavorite: Int, sale: Int, categoryId: Int,barCode: String, sellId: Int) {
        self.id = id
        self.price = price
        self.title = title
        self.description = description
        self.numberFavorite = numberFavorite
        self.sale = sale
        self.categoryId = categoryId
        self.barCode = barCode
        self.sellId = sellId
    }
}
