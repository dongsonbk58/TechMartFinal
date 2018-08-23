//
//  SignUpNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol SignupNavigatorType {
    func toSignup()
    func toDismiss()
    func toProfile()
}

struct SignupNavigator: SignupNavigatorType {

    unowned let navigationViewController: UINavigationController
    
    func toSignup() {
        let signUpViewController = SignUpViewController.instantiateFromNib()
        let usercase = SignUpUseCase()
        let viewmodel = SignUpViewModel(useCase: usercase, navigator: self)
        signUpViewController.bindViewModel(to: viewmodel)
        navigationViewController.pushViewController(signUpViewController, animated: true)
    }
    
    func toDismiss() {
        navigationViewController.popViewController(animated: true)
    }
    
    func toProfile() {
        let navigator = ProfileNavigator(navigationController: navigationViewController)
        navigator.toProfile()
    }
}
