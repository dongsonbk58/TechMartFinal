//
//  LoginUserCase.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol LoginUseCaseType {
    func login( username: String, password: String) -> Observable<Void>
}

struct LoginUseCase: LoginUseCaseType {
    func login( username: String, password: String) -> Observable<Void> {
        return Observable.just(())
    }
}

