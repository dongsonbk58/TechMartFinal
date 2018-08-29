//
//  CartUseCase.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol CartUseCaseType {
    func getListCart() -> Observable<[Cart]>
    func removeProduct(idProduct: Int) -> Observable<Bool>
    func updateCart(cart: Cart) -> Observable<Bool>
    func remoteCart(cart: Cart) ->Observable<Bool>
}

struct CartUseCase: CartUseCaseType {
    func removeProduct(idProduct: Int) -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func getListCart() -> Observable<[Cart]> {
        var cartData: [Cart] = []
        cartData.append(Cart(product: Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1), count: 1))
        cartData.append(Cart(product: Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1), count: 10))
        cartData.append(Cart(product: Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1), count: 20))
        return Observable.just(cartData)
    }
    
    func updateCart(cart: Cart) -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func remoteCart(cart: Cart) ->Observable<Bool> {
        return Observable.just(true)
    }
}
