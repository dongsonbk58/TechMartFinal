//
//  BarCodeNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/30/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
protocol BarCodeNavigatorType {
    func toBarCode()
    func toDetail(idProduct: Int)
    func confirmGoDetailProduct(idProduct: Int) -> Driver<Void>
}

struct BarCodeNavigator: BarCodeNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toBarCode() {
        let barCodeVc = BarCodeViewController.instantiate()
        let vm = BarCodeViewModel(useCase: BarCodeUseCase(), navigation: self)
        barCodeVc.bindViewModel(to: vm)
        navigationController.pushViewController(barCodeVc, animated: true)
    }
    
    func toDetail(idProduct: Int) {
        let navigation = DetailProductionNavigator(navigationController: navigationController)
        navigation.toDetail(idProduct: idProduct)
    }
    
    func confirmGoDetailProduct(idProduct: Int) -> Driver<Void> {
        return Observable<Void>.create({ observable -> Disposable in
            let alert = UIAlertController(
                title: "Go Detail Product"
                , message: "Are you ok?"
                , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                observable.onNext(())
                observable.onCompleted()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                observable.onCompleted()
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.navigationController.present(alert, animated: true, completion: nil)
            return Disposables.create {
                alert.dismiss(animated: true, completion: nil)
            }
        })
            .asDriverOnErrorJustComplete()
    }
}
