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
    func toHome()
}

struct LoginNavigator :LoginNavigatorType {
    
    unowned let navigationViewController: UINavigationController

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
    
    func toHome() {
        let navigator = HomeNavigator(navigationController: navigationViewController)
        navigator.toHome()
    }
}
