//
//  ProfileViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct ProfileViewModel: ViewModelType {
    
    let usecase: ProfileUseCaseType
    let navigator: ProfileNavigatorType
    
    func transform(_ input: ProfileViewModel.Input) -> ProfileViewModel.Output {
        let back = input.backTrigger.do(onNext: {
            self.navigator.toDismiss()
        })
        
        let ok = input.oktrigger
        
        let pickerImage = input.imageViewTrigger.mapToVoid()
        return Output(backTrigger: back,
                      okTrigger: ok,
                      imageViewTrigger: pickerImage)
    }
    
    struct Input {
        let fullName: Driver<String>
        let address: Driver<String>
        let age: Driver<String>
        let avatar: Driver<UIImage>
        let backTrigger: Driver<Void>
        let oktrigger: Driver<Void>
        let imageViewTrigger: Driver<UITapGestureRecognizer>
    }
    
    struct Output {
        let backTrigger: Driver<Void>
        let okTrigger: Driver<Void>
        let imageViewTrigger: Driver<Void>
        
    }
}
