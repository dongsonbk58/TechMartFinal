//
//  MainViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct MainViewModel: ViewModelType {
    
    let useCase: MainUseCaseType
    let navigator: MainNavigatorType
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: MainViewModel.Input) -> MainViewModel.Output {
        return Output()
    }
}
