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
            .do(onNext: { (product) in
                self.navigation.toDetail(idProduct: product.id)
            })
            .mapToVoid()
        return Output(error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      refreshing: input.reloadTrigger,
                      productList: data,
                      selectedProduct: selectedProduct)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let selectRepoTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Void>
        let productList: Driver<[Product]>
        let selectedProduct: Driver<Void>
    }
}
