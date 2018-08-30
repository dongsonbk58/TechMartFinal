//
//  MainTabBarController.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = .red
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let tabBarItemType = TabBarItemType(rawValue: item.tag) else { return }
        NotificationCenter.default.post(name: Notification.Name.changeTab,
                                        object: tabBarItemType)
    }
    
    deinit {
        logDeinit()
    }
}
