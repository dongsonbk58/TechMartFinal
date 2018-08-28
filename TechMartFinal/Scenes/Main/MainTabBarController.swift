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
      //  self.tabBarItem.
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
