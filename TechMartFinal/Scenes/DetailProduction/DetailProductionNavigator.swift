//
//  DetailProductionNavigator.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

protocol DetailProductionNavigatorType {
    func dismiss()
    func toDetail(idProduct: Int)
}

struct DetailProductionNavigator: DetailProductionNavigatorType {
    unowned let navigationController: UINavigationController
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
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
