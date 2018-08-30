//
//  BarCodeViewModel.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct BarCodeViewModel: ViewModelType {
    
    let useCase: BarCodeUseCaseType
    let navigation: BarCodeNavigatorType
    
    func transform(_ input: BarCodeViewModel.Input) -> BarCodeViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let idProduct = input.barCode
            .distinctUntilChanged()
            .flatMapLatest({ barcode -> Driver<Int> in
                if barcode != "" {
                    return self.useCase.getIdProduct(barCode: barcode)
                        .trackError(errorTracker)
                        .trackActivity(activityIndicator)
                        .asDriverOnErrorJustComplete()
                }
                return Driver.empty()
            })
            .flatMapLatest({ idProduct -> Driver<Int> in
                print(idProduct)
                return self.navigation.confirmGoDetailProduct(idProduct: idProduct)
                    .map { idProduct}
            })
            .do(onNext: { (idProduct) in
                self.navigation.toDetail(idProduct: idProduct)
            })
            .mapToVoid()
        return Output(goDetail: idProduct,
                      loading: activityIndicator.asDriver(),
                      error: errorTracker.asDriver())
    }
    
    struct Input {
        let barCode: Driver<String>
    }
    
    struct Output {
        let goDetail: Driver<Void>
        let loading: Driver<Bool>
        let error: Driver<Error>
    }
}
