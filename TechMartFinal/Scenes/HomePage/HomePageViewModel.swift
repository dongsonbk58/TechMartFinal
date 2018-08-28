//
//  HomePageViewModel.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct HomePageViewModel: ViewModelType {
    
    let useCase: HomePageUseCaseType
    let navigator: HomePageNavigatorType
    
    func transform(_ input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let data = input.loadTrigger
        .flatMapLatest { _ in
            return self.useCase.loadData()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        return Output(data: data,
                      loading: activityIndicator.asDriver())
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<Void>
        let loading: Driver<Bool>
    }
}
