//
//  File.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct ForgotPasswordViewModel: ViewModelType {

    let useCase: ForgotPasswordUseCaseType
    let navigator: ForgotPasswordNavigatorType
    
    struct Input {
        let backButton: Driver<Void>
        let resetPassword: Driver<Void>
        let email: Driver<String>
    }

    struct Output {
        let enableButton: Driver<Bool>
        let back: Driver<Void>
        let reset: Driver<Void>
        let validEmail: Driver<Bool>
    }

    func transform(_ input: ForgotPasswordViewModel.Input) -> ForgotPasswordViewModel.Output {
        let enableButton = input.email.map {
            !$0.isEmpty
        }
        let back = input.backButton
            .do(onNext: {
              self.navigator.toDismis()
            })
        let reset = input.resetPassword
            .do(onNext: {
                
            })
        let validEmail = input.email.map{
            $0.isValidEmail()
        }
        return Output(enableButton: enableButton,
                      back: back,
                      reset: reset,
                      validEmail: validEmail)
    }
}
