//
//  HomePageViewModel.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

struct HomePageViewModel: ViewModelType {
    
    let useCase: HomePageUseCaseType
    let navigator: HomePageNavigatorType
    
    enum CellInfoType: String {
        case collection
        case tableView
    }
    
    struct CellInfo {
        let type: CellInfoType
        let category: [Category]
    }
    
    struct SectionInfo {
        let identifier: String
        let cells: [CellInfo]
    }
    
    func transform(_ input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let data = input.loadTrigger
        .flatMapLatest { _ in
            return self.useCase.loadData()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        let secsion = input.loadTrigger.flatMapLatest {
            return self.useCase.loadCategory().asDriverOnErrorJustComplete()
            }.map {
                [SectionInfo(identifier: "", cells: [CellInfo(type: .collection, category: $0)])]
            }
        return Output(data: data,
                      loading: activityIndicator.asDriver(),
                      error: errorTracker.asDriver(),
                      sections: secsion)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<Void>
        let loading: Driver<Bool>
        let error: Driver<Error>
        let sections: Driver<[SectionInfo]>
    }
    
//    private func configDataSource() -> [SectionInfo] {
//        let section:[SectionInfo] = [SectionInfo(identifier: "", cells: [
//            CellInfo(type: .collection)]), SectionInfo(identifier: "", cells: [
//                CellInfo(type: .tableView)])]
//        return section
//    }
}
