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
    
    let repository: DirectionRepositoryType
    
    func getDirection(place1: PlaceData, place2: PlaceData) -> Observable<GMSPath> {
        return repository.getDirection(place1: place1, place2: place2)
      
    }
}
