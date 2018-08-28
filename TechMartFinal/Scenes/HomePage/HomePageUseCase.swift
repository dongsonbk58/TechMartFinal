//
//  HomePageUseCase.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol HomePageUseCaseType {
    func loadData() -> Observable<Void>
}

struct HomePageUseCase: HomePageUseCaseType {
    func loadData() -> Observable<Void> {
        return Observable.just(())
    }
}
