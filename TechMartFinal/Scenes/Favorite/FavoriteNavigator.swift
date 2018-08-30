//
//  FavoriteNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol FavoriteNavigatorType {
    func toFavorite()
    func toDetail(idProduct: Int)
}

struct FavoriteNavigator: FavoriteNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toFavorite() {
        let favoriteVC = FavoriteViewController.instantiate()
        let vm = FavoriteViewModel(useCase: FavoriteUseCase(), navigator: self)
        favoriteVC.bindViewModel(to: vm)
        navigationController.pushViewController(favoriteVC, animated: true)
    }
    
    func toDetail(idProduct: Int) {
        let detailVc = DetailProductionViewController.instantiate()
        let baseNav = BaseNavigationController(rootViewController: detailVc)
        let navigator = DetailProductionNavigator(navigationController: navigationController)
        let vm = DetailProductionViewModel(useCase: DetailProductionUseCase(), navigator: navigator, productId: idProduct)
        detailVc.bindViewModel(to: vm)
        navigationController.present(baseNav, animated: true, completion: nil)
    }
}
