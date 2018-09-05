//
//  MapViewModel.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct MapViewModel: ViewModelType {
    
    let useCase: MapUseCaseType
    let navigtion: MapNavigatorType
    
    func transform(_ input: MapViewModel.Input) -> MapViewModel.Output {
        let place1Trigger = input.place1Trigger.flatMap {
            Driver.just(1)
        }
        
        let place2Trigger = input.place2Trigger.flatMap {
            Driver.just(2)
        }
        return Output(loadTrigger: input.loadTrigger,
                      place1Trigger: place1Trigger,
                      place2Trigger: place2Trigger)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let place1Trigger: Driver<Void>
        let place2Trigger: Driver<Void>
    }
    
    struct Output {
        let loadTrigger: Driver<Void>
        let place1Trigger: Driver<Int>
        let place2Trigger: Driver<Int>
    }
}
