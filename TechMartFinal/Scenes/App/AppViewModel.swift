//
//  AppViewModel.swift
//  demoCleanDiv3
//
//  Created by ThanhLong on 7/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct AppViewModel: ViewModelType {

    let useCase: AppUseCaseType
    let navigator: AppNavigatorType

    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
        let toLogin: Driver<Void>
    }

    func transform(_ input: AppViewModel.Input) -> AppViewModel.Output {
        let toLogin = input.loadTrigger.do(onNext: {
            self.navigator.toLogin()
        })
        return Output(toLogin: toLogin)
    }
}

