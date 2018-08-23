//
//  HomeNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol HomeNavigatorType {
    func toHome()
}

struct HomeNavigator: HomeNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toHome() {
        let homeVC = HomeViewController.instantiate()
        navigationController.pushViewController(homeVC, animated: true)
    }
}
