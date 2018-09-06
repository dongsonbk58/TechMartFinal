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
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let place1Trigger = input.place1Trigger.flatMap {
            Driver.just(1)
        }
        
        let place2Trigger = input.place2Trigger.flatMap {
            Driver.just(2)
        }
        
        let direction = input.directionTrigger
            .flatMapLatest {
                return self.useCase.getDirection(place1: $0.0, place2: $0.1)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        return Output(loadTrigger: input.loadTrigger,
                      place1Trigger: place1Trigger,
                      place2Trigger: place2Trigger,
                      direction: direction,
                      error: errorTracker.asDriver(),
                      indicator: activityIndicator.asDriver())
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let place1Trigger: Driver<Void>
        let place2Trigger: Driver<Void>
        let directionTrigger: Driver<(PlaceData, PlaceData)>
    }
    
    struct Output {
        let loadTrigger: Driver<Void>
        let place1Trigger: Driver<Int>
        let place2Trigger: Driver<Int>
        let direction: Driver<GMSPath>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
}
