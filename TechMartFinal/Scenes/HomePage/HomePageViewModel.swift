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
        return Output()
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
}
