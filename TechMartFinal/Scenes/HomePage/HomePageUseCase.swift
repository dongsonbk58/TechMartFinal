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
    func loadCategory() -> [Category]
    func loadCategoryDetail() -> [CategoryDetail]
    func loadDataCategory() -> Observable<[HomePageViewModel.SectionInfo]>
}

struct HomePageUseCase: HomePageUseCaseType {
    func loadData() -> Observable<Void> {
        return Observable.just(())
    }
    
    func loadCategory() -> [Category] {
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
        data.append(tmp)
        data.append(tmp)
        return data
    }
    
    func loadCategoryDetail() -> [CategoryDetail] {
        var data = [CategoryDetail]()
        var product = [Product]()
        let tmpProduct = Product(id: 1, title: "abc", price: 1000, description: "aaa", numberFavorite: 10, sale: 10, categoryId: 1, barCode: "aaa", sellId: 10)
        product.append(tmpProduct)
        product.append(tmpProduct)
        product.append(tmpProduct)
        let tmp = CategoryDetail(category: Category(title: "", image: "a"), product: product, background: "aa")
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        data.append(tmp)
        return data
    }
    
    func loadDataCategory() -> Observable<[HomePageViewModel.SectionInfo]> {
        var data = [HomePageViewModel.SectionInfo]()
        let dataCategory = HomePageViewModel.SectionInfo(identifier: "Danh muc san pham", cells: [HomePageViewModel.CellInfo(type: .collection, category: loadCategory(), categoryDetail: nil)])
        let dataCategoryDetail = HomePageViewModel.SectionInfo(identifier: "", cells: [HomePageViewModel.CellInfo(type: .tableView, category: nil, categoryDetail: loadCategoryDetail())])
        let slider = HomePageViewModel.SectionInfo(identifier: "", cells: [HomePageViewModel.CellInfo(type: .slider, category: nil, categoryDetail: nil)])
        data.append(slider)
        data.append(dataCategory)
        data.append(dataCategoryDetail)
        return Observable.just(data)
    }
}
