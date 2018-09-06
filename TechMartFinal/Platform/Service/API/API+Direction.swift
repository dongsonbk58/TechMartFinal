//
//  API+Direction.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//
import ObjectMapper

extension API {
    final class GetDirectionInput: APIInput {
        init(place1: PlaceData, place2: PlaceData) {
            let params: JSONDictionary = [
                "origin": "\(place1.lat),\(place1.long)",
                "destination": "\(place2.lat),\(place2.long)",
                "sensor": true,
                "key": "AIzaSyAeOBaSr60qpMhvEE18dUBD3eXDX7lLXh0"
                ]
            super.init(urlString: API.Urls.getDirection,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
    
    final class GetDirectionOutput: APIOutput {
        private(set) var direction: GMSPath?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            direction <- map["routes"]["0"]["overview_polyline"]["points"]
        }
    }
}
