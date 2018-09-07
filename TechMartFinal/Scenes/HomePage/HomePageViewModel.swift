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
    let homePage: HomePageModel?
    
    enum CellInfoType: String {
        case slider
        case collection
        case tableView
    }
    
    class HomePageModel: Then {
        var category: [Category] = []
        var categoryDetail: [CategoryDetail] = []
    }
    
    struct CellInfo {
        let type: CellInfoType
    }
    
    struct SectionInfo {
        let identifier: String
        let cells: [CellInfo]
    }
    
    func transform(_ input: HomePageViewModel.Input) -> HomePageViewModel.Output {
        let defaultData = homePage ?? HomePageModel()
        let homePageSubject = BehaviorRelay<HomePageModel>(value: defaultData)
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let data = input.loadTrigger
        .flatMapLatest { _ in
            return self.useCase.loadData()
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        let secsion = input.loadTrigger
            .withLatestFrom(homePageSubject.asDriverOnErrorJustComplete())
            .map { subject -> [SectionInfo] in
                let tmp = HomePageModel()
                tmp.category = self.useCase.loadCategory()
                tmp.categoryDetail = self.useCase.loadCategoryDetail()
                homePageSubject.accept(tmp)
                return self.configDataSource(homePageSubject: subject)
        }
        
        
        return Output(data: data,
                      homePageData: homePageSubject.asDriverOnErrorJustComplete(),
                      loading: activityIndicator.asDriver(),
                      error: errorTracker.asDriver(),
                      sections: secsion)
    }
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<Void>
        let homePageData: Driver<HomePageModel>
        let loading: Driver<Bool>
        let error: Driver<Error>
        let sections: Driver<[SectionInfo]>
    }
    
    private func configDataSource(homePageSubject: HomePageModel) -> [SectionInfo] {
        let sectionOne = SectionInfo(identifier: "", cells: [CellInfo(type: .slider)])
        let sectionTwo = SectionInfo(identifier: "", cells: [CellInfo(type: .collection)])
        let sectionThree = SectionInfo(identifier: "", cells: [CellInfo(type: .tableView)])
        return [sectionOne, sectionTwo, sectionThree]
    }
}

