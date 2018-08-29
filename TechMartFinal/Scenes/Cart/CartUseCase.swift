//
//  CartUseCase.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol CartUseCaseType {
    func getListCart() -> Observable<[Product]>
    func removeProduct(idProduct: Int) -> Observable<Bool>
}

struct CartUseCase: CartUseCaseType {
    func removeProduct(idProduct: Int) -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func getListCart() -> Observable<[Product]> {
        return Observable.just([])
    }
}
