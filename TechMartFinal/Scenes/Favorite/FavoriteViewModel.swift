//
//  FavoriteViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct FavoriteViewModel: ViewModelType {
    
    let useCase: FavoriteUseCaseType
    let navigator: FavoriteNavigatorType
    
    func transform(_ input: FavoriteViewModel.Input) -> FavoriteViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let listProduct = input.loadTrigger
            .flatMapLatest {
                return self.useCase.getListFavorite()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let selectedProduct = input.selected.withLatestFrom(listProduct) {
            $1[$0.row]
            }
            .do(onNext: {
                self.navigator.toDetail(idProduct: $0.id)
            })
            .mapToVoid()
        
        return Output(error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      refreshing: input.reloadTrigger,
                      productList: listProduct.asDriver(),
                      selectedProduct: selectedProduct)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selected: Driver<IndexPath>
        let reloadTrigger: Driver<Void>
        
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Void>
        let productList: Driver<[Product]>
        let selectedProduct: Driver<Void>
    }
}
