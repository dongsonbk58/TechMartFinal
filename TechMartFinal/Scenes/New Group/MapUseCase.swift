//
//  MapUseCase.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
import Alamofire

protocol MapUseCaseType {
    func getDirection(place1: PlaceData, place2: PlaceData) -> Observable<GMSPath>
}

struct MapUseCase: MapUseCaseType {
    func getDirection(place1: PlaceData, place2: PlaceData) -> Observable<GMSPath> {
        let urlRequest = "https://maps.googleapis.com/maps/api/directions/json?origin=\(place1.lat),\(place1.long)(&destination=\(place2.lat),\(place2.long)&sensor=true&key=AIzaSyDPpRYrSmZFNxXeGe6k8QDRHMv9AXK95o4"
        
      
    }
}
