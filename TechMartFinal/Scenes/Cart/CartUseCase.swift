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
        var datas: [Product] = []
        datas.append(Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1))
         datas.append(Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1))
         datas.append(Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1))
        return Observable.just(datas)
    }
}
