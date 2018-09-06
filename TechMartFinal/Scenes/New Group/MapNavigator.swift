//
//  MapNavigator.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
protocol MapNavigatorType {
    func toMap()
}

struct MapNavigator: MapNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toMap() {
        let mapVc = MapViewController.instantiate()
        let vm = MapViewModel(useCase: MapUseCase(repository: DirectionRepository()), navigtion: self)
        mapVc.bindViewModel(to: vm)
        navigationController.pushViewController(mapVc, animated: true)
    }
}
