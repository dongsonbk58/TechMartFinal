//
//  CartViewModel.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct CartViewModel: ViewModelType {
    
    let usecase: CartUseCaseType
    let navigation: CartNavigatorType
    
    func transform(_ input: CartViewModel.Input) -> CartViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let data = input.loadTrigger.flatMapLatest {
            return self.usecase.getListCart()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        let selectedProduct = input.selectRepoTrigger
            .withLatestFrom(data) {
                return ($0, $1)
            }
            .map { indexPath, dataList in
                return dataList[indexPath.row]
            }
            .do(onNext: { (cart) in
                self.navigation.toDetail(idProduct: cart.product?.id ?? 0)
            })
            .mapToVoid()
        
        let decProduct = input.decProduct.withLatestFrom(data) { indexPath, listData -> Cart in
                listData[indexPath.row].count -= 1
                return listData[indexPath.row]
            }
            .flatMapLatest {
                return self.usecase.updateCart(cart: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .filter {
                $0
            }
            .mapToVoid()
        
        let incProduct = input.incProduct.withLatestFrom(data) { indexPath, listData -> Cart in
            listData[indexPath.row].count += 1
            return listData[indexPath.row]
            }
            .flatMapLatest {
                return self.usecase.updateCart(cart: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .filter {
                $0
            }
            .mapToVoid()
        
        let removeProduct = input.removeProduct.withLatestFrom(data) { indexPath, listData -> Cart in
                return listData[indexPath.row]
            }
            .flatMapLatest {
                return self.usecase.remoteCart(cart: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .filter {
                $0
            }
            .mapToVoid()
        
        return Output(error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      refreshing: input.reloadTrigger,
                      productList: data,
                      selectedProduct: selectedProduct,
                      decProduct: decProduct,
                      incProduct: incProduct,
                      removeProduct: removeProduct)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectRepoTrigger: Driver<IndexPath>
        let decProduct: Driver<IndexPath>
        let incProduct: Driver<IndexPath>
        let removeProduct: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Void>
        let productList: Driver<[Cart]>
        let selectedProduct: Driver<Void>
        let decProduct: Driver<Void>
        let incProduct: Driver<Void>
        let removeProduct: Driver<Void>
    }
}
