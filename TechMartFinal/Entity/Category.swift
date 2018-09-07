//
//  Category.swift
//  TechMartFinal
//
//  Created by ThanhLong on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

class Category {
    var title: String
    var image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}

class CategoryDetail {
    var category: Category
    var product: [Product]
    var background: String
    
    init(category: Category, product: [Product], background: String) {
        self.category = category
        self.product = product
        self.background = background
    }
}
