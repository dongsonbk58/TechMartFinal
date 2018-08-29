//
//  FavoriteUseCase.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol FavoriteUseCaseType {
    func getListFavorite() -> Observable<[Product]>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    func getListFavorite() -> Observable<[Product]> {
        return Observable.just([Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1), Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1), Product(id: 1, title: "abcdddddd", price: 100000, description: "abcddd", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaaaa", sellId: 1)])
    }
}
