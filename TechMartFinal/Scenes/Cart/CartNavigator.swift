//
//  CartNavigator.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol CartNavigatorType {
    func toDetail(idProduct: Int)
    func toCart()
}

struct CartNavigator: CartNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toDetail(idProduct: Int) {
        
    }
    
    func toCart() {
        let cartVc = CartViewController.instantiate()
        let vm = CartViewModel(usecase: CartUseCase(), navigation: self)
        cartVc.bindViewModel(to: vm)
        navigationController.pushViewController(cartVc, animated: true)
    }
}
