//
//  AppNavigator.swift
//  demoCleanDiv3
//
//  Created by ThanhLong on 7/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
import UIKit

protocol AppNavigatorType {
    func toLogin()
}

struct AppNavigator: AppNavigatorType {

    unowned let window: UIWindow

    func toLogin() {
        let loginVC = LoginViewController.instantiate()
        let navi = UINavigationController(rootViewController: loginVC)
        let mainNavigator = LoginNavigator(navigationViewController: navi, window: window)
        let useCase = LoginUseCase()
        let vm = LoginViewModel(useCase: useCase, navigator: mainNavigator)
        loginVC.bindViewModel(to: vm)
        window.rootViewController = navi
    }
}
