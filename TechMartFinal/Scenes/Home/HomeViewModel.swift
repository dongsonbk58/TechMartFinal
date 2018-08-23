//
//  HomeViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct HomeViewModel: ViewModelType {
    
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        return Output()
    }
}
