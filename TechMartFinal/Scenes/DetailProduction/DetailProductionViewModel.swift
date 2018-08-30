//
//  DetailProductionViewModel.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

struct DetailProductionViewModel:ViewModelType {
    let useCase: DetailProductionUseCaseType
    let navigator: DetailProductionNavigatorType
    let productId: Int

    enum CellInfoType: String {
        case imageDetail
        case countProduct
    }
    
    struct CellInfo {
        let type: CellInfoType
    }
    
    struct SectionInfo {
        let identifier: String
        let cells: [CellInfo]
    }
    
    struct Input {
        let firstLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let sections: Driver<[SectionInfo]>
        let error: Driver<Error>
        let indicator: Driver<Bool>
    }
    
    func transform(_ input: DetailProductionViewModel.Input) -> DetailProductionViewModel.Output {
        
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let sections = input.firstLoadTrigger.map {
            return self.configDataSource()
        }
        
        return Output(sections: sections,
                      error: errorTracker.asDriver(),
                      indicator: activityIndicator.asDriver())
    }
    
    private func configDataSource() -> [SectionInfo] {
        let section:[SectionInfo] = [SectionInfo(identifier: "", cells: [
                CellInfo(type: .imageDetail),
                CellInfo(type: .countProduct)])]
        return section
    }
}
