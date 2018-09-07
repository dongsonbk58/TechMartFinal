//
//  HomePageNavigator.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol HomePageNavigatorType {
    func toHomePage()
}

struct HomepageNavigator: HomePageNavigatorType {
    unowned let navigationController: UINavigationController
    
    func toHomePage() {
        let homePageVC = HomePageViewController.instantiate()
        let vm = HomePageViewModel(useCase: HomePageUseCase(), navigator: self, homePage: HomePageViewModel.HomePageModel())
        homePageVC.bindViewModel(to: vm)
        navigationController.pushViewController(homePageVC, animated: true)
    }
}
