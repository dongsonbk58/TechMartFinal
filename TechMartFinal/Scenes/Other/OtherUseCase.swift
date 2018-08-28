//
//  OtherUseCase.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol OtherUseCaseType {
    func reloadUserInformation() -> Observable<User>
}

struct OtherUseCase: OtherUseCaseType {
    func reloadUserInformation() -> Observable<User> {
        let user = User(id: 1, name: "son", email: "son@gmail.com", imageProfileUrl: nil, imageCoverUrl: nil, gender: .male, userId: "son")
        return Observable.just(user)
    }
}
