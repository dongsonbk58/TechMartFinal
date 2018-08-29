//
//  CartViewModel.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct CartViewModel: ViewModelType {
    
    let usecase: CartUseCaseType
    let navigation: CartNavigatorType
    
    func transform(_ input: CartViewModel.Input) -> CartViewModel.Output {
        return Output()
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        
    }
}
