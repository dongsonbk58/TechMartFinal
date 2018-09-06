//
//  DirectionRepository.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

protocol DirectionRepositoryType {
    func getDirection(place1: PlaceData, place2: PlaceData) -> Observable<GMSPath>
}

final class DirectionRepository: DirectionRepositoryType {
    func getDirection(place1: PlaceData, place2: PlaceData) -> Observable<GMSPath> {
        let input = API.GetDirectionInput(place1: place1, place2: place2)
        let output: Observable<API.GetDirectionOutput> = API.shared.request(input)
        return output.map({ output in
            guard let direction = output.direction else {
                throw APIInvalidResponseError()
            }
            return direction
        })
    }
}
