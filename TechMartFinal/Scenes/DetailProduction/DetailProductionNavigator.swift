//
//  DetailProductionNavigator.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

protocol DetailProductionNavigatorType {
    func dismiss()
}

struct DetailProductionNavigator: DetailProductionNavigatorType {
    unowned let navigationController: UINavigationController
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
