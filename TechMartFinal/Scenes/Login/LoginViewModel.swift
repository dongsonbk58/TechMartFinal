//
//  LoginViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

private struct Constants {
    static let invalidEmailAlert = "LoginVC.alert.invalidEmail".localized()
    static let invalidPasswordAlert = "LoginVC.alert.invalidPass".localized()
    static let minCharOfPassword = 6
}

struct LoginViewModel: ViewModelType {
 
    let useCase: LoginUseCaseType
    let navigator: LoginNavigatorType
    
    struct Input {
        let loginTrigger: Driver<Void>
        let signupTrigger: Driver<Void>
        let username: Driver<String>
        let password: Driver<String>
        let forgorPassword: Driver<Void>
    }
    struct Output {
        let isLogin: Driver<Void>
        let error: Driver<Error>
        let indicator: Driver<Bool>
        let enableButton: Driver<Bool>
        let signUp: Driver<Void>
        let forgot: Driver<Void>
    }

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let emailAndPassword = Driver.combineLatest(input.username, input.password) {
            (email: $0, password: $1)
        }
        
        let enableButton = emailAndPassword.map {
            !$0.email.isEmpty && !$0.password.isEmpty
        }
        
        let isValidMail = emailAndPassword.flatMapLatest({ (email, password) -> Driver<(Bool, String)> in
            guard email.isValidEmail() else {
                return Driver<(Bool, String)>.just((false, Constants.invalidEmailAlert))
            }
            guard password.count >= Constants.minCharOfPassword else {
                return Driver<(Bool, String)>.just((false, Constants.invalidPasswordAlert))
            }
            return Driver<(Bool, String)>.just((true, ""))
        })
        
        let signUp = input.signupTrigger
            .do(onNext: {
                self.navigator.toSignUp()
            })
        
        let forgot = input.forgorPassword
            .do(onNext: {
                self.navigator.toForgotPassword()
            })
        
        let login = input.loginTrigger
            .withLatestFrom(isValidMail)
            .filter{
                $0.0
            }
            .withLatestFrom(emailAndPassword)
            .flatMapLatest{
                return self.useCase.login(username: $0.email, password: $0.password)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: {
                self.navigator.toHome()
            })

        return Output(isLogin: login,
                      error: errorTracker.asDriver(),
                      indicator: activityIndicator.asDriver(),
                      enableButton: enableButton,
                      signUp: signUp,
                      forgot: forgot)
    }
}
