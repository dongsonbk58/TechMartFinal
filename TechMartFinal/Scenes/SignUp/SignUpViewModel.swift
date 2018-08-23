//
//  SignUpViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

private struct Constants {
    static let errorPasswordSignUp = "SignUpVC.error.notmatching".localized()
    static let errorInvalidEmail = "SignUpVC.error.invalidEmail".localized()
    static let isExitEmail = "SignUpVC.error.exitEmail".localized()
    static let minCharOfPassword = 6
    static let countPassword = "SignUpVC.error.countPassword".localized()
}

struct SignUpViewModel: ViewModelType {
    
    let useCase: SignUpUseCaseType
    let navigator: SignupNavigatorType
    
    struct Input {
        let email: Driver<String>
        let password: Driver<String>
        let rePassword: Driver<String>
        let signup: Driver<Void>
        let back: Driver<Void>
    }
    
    struct Output {
        let signup: Driver<Bool>
        let back: Driver<Void>
        let enableButton: Driver<Bool>
        let checkValid: Driver<(Bool, String)>
    }
    
    func transform(_ input: SignUpViewModel.Input) -> SignUpViewModel.Output {
        let data = Driver.combineLatest(input.email, input.password, input.rePassword) {
            (email: $0, password: $1, repassword: $2)
        }
        
        let check = PublishSubject<(Bool, String)>()
        
        let enableButton = data.map {
            !$0.email.isEmpty && !$0.password.isEmpty && !$0.repassword.isEmpty
        }
        
        let back = input.back
            .do(onNext: {
                self.navigator.toDismiss()
            })
        
        let checkVaild = data.flatMapLatest { check -> Driver<(Bool, String)> in
            if !check.email.isValidEmail() {
                return Driver.just((false, Constants.errorInvalidEmail))
            }
            if !(check.password == check.repassword) {
                return Driver.just((false, Constants.errorPasswordSignUp))
            }
            if check.password.count < Constants.minCharOfPassword {
                return Driver.just((false, Constants.countPassword))
            }
            return Driver.just((true, ""))
        }
        
        let signup = input.signup
            .withLatestFrom( checkVaild)
            .flatMapLatest { data -> Driver<Bool> in
                check.onNext(data)
                return Driver.just(data.0)
            }.do(onNext: {
                if $0 {
                    self.navigator.toProfile()
                }
            })
        
        return Output(signup: signup,
                      back: back,
                      enableButton: enableButton,
                      checkValid: check.asDriverOnErrorJustComplete())
    }
}
