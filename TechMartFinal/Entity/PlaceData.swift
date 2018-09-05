//
//  PlaceData.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

class PlaceData: NSObject {
    var lat: Float = 0.0
    var long: Float = 0.0
    var title: String = ""
    
    override init() {
        
    }
    
    init(lat: Float, long: Float, title: String) {
        self.lat = lat
        self.long = long
        self.title = title
    }
}
