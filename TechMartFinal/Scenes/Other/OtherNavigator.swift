//
//  OtherNavigator.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol OtherNavigatorType {
    func toOther()
    func toBarCode()
    func toMap()
}

struct OtherNavigator: OtherNavigatorType {
    let navigationController: UINavigationController
    
    func toOther() {
        let vc = OtherViewController.instantiate()
        let vm = OtherViewModel(navigator: self,
                                useCase: OtherUseCase())
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func toBarCode() {
        let navigation = BarCodeNavigator(navigationController: navigationController)
        navigation.toBarCode()
    }
    
    func toMap() {
        let navigation = MapNavigator(navigationController: navigationController)
        navigation.toMap()
    }
}
