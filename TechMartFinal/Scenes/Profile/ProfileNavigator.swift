//
//  ProfileNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation

protocol ProfileNavigatorType {
    func toProfile()
    func toDismiss()
}

struct ProfileNavigator: ProfileNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func toProfile() {
        let profileVc = ProfileViewController.instantiateFromNib()
        let usecase = ProfileUsecase()
        let viewModel = ProfileViewModel(usecase: usecase, navigator: self)
        profileVc.bindViewModel(to: viewModel)
        navigationController.pushViewController(profileVc, animated: true)
    }
    
    func toDismiss() {
        navigationController.popViewController(animated: true)
    }
}
