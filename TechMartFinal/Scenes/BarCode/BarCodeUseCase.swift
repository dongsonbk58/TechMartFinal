//
//  BarCodeUseCase.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol BarCodeUseCaseType {
    func getIdProduct(barCode: String) -> Observable<Int>
}

struct BarCodeUseCase: BarCodeUseCaseType {
    func getIdProduct(barCode: String) -> Observable<Int> {
        return Observable.just(1)
    }
}
