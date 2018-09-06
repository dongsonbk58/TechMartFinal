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
    func loadCategory() -> Observable<[Category]>
}

struct HomePageUseCase: HomePageUseCaseType {
    func loadData() -> Observable<Void> {
        return Observable.just(())
    }
    
    func loadCategory() -> Observable<[Category]> {
        var data = [Category]()
        let tmp = Category(title: "abcd", image: "aa")
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        return Observable.just(data)
    }
}
