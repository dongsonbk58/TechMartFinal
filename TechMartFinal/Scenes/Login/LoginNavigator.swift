//
//  LoginNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol LoginNavigatorType {
    func toLogin()
    func toSignUp()
    func toForgotPassword()
    func toMain()
}

struct LoginNavigator :LoginNavigatorType {
    
    unowned let navigationViewController: UINavigationController
    let window: UIWindow!

    func toLogin() {
        
    }

    func toSignUp() {
        let navigator = SignupNavigator(navigationViewController: navigationViewController)
        navigator.toSignup()
    }

    func toForgotPassword() {
        let navigator = ForgotPasswordNavigator(navigationViewController: navigationViewController)
        navigator.toForgotPassword()
    }
    
    func toMain() {
        let navigator = MainNavigator(navigationController: navigationViewController, window: window)
        navigator.toMain()
    }
}
