//
//  ForgotPasswordNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/22/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol ForgotPasswordNavigatorType {
    func toForgotPassword()
    func toDismis()
}

struct ForgotPasswordNavigator: ForgotPasswordNavigatorType {
    
    unowned let navigationViewController: UINavigationController
    
    func toForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController.instantiateFromNib()
        let usercase = ForgotPasswordUseCase()
        let viewmodel = ForgotPasswordViewModel(useCase: usercase, navigator: self)
        forgotPasswordVC.bindViewModel(to: viewmodel)
        navigationViewController.pushViewController(forgotPasswordVC, animated: true)
    }
    
    func toDismis() {
        navigationViewController.popViewController(animated: true)
    }
}
