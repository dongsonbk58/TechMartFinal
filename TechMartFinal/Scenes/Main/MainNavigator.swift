//
//  MainNavigator.swift
//  TechMartFinal
//
//  Created by ThanhLong on 8/23/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import Foundation
import UIKit

protocol MainNavigatorType {
    func toMain()
}

struct MainNavigator: MainNavigatorType {
    
    unowned let navigationController: UINavigationController
    let window: UIWindow
    
    func toMain() {
        let homeNav = BaseNavigationController().then {
            $0.tabBarItem = UITabBarItem(title: "Home",
                                         image: #imageLiteral(resourceName: "tab_bulletin"),
                                         selectedImage: #imageLiteral(resourceName: "tab_bulletin_selected"))
                .then {
                    $0.tag = TabBarItemType.home.rawValue
            }
        }

        let cartNav = BaseNavigationController().then {
            $0.tabBarItem = UITabBarItem(title: "Cart",
                                         image: #imageLiteral(resourceName: "cart"),
                                         selectedImage: #imageLiteral(resourceName: "cart_selected"))
                .then {
                    $0.tag = TabBarItemType.cart.rawValue
            }
        }

//        let favoriteNav = BaseNavigationController().then {
//            $0.tabBarItem = UITabBarItem(title: "Favorite",
//                                         image: #imageLiteral(resourceName: "tabbar_icon_todo_off"),
//                                         selectedImage: #imageLiteral(resourceName: "tabbar_icon_todo_on"))
//                .then {
//                    $0.tag = TabBarItemType.favorite.rawValue
//            }
//        }
//
//        let sellNav = BaseNavigationController().then {
//            $0.tabBarItem = UITabBarItem(title: "Sell",
//                                         image: #imageLiteral(resourceName: "tabbar_icon_calendar_off"),
//                                         selectedImage: #imageLiteral(resourceName: "tabbar_icon_calendar_on"))
//                .then {
//                    $0.tag = TabBarItemType.sell.rawValue
//            }
//        }
        
        let otherNav = BaseNavigationController().then {
            $0.tabBarItem = UITabBarItem(title: "Other",
                                         image: #imageLiteral(resourceName: "tab_other"),
                                         selectedImage: #imageLiteral(resourceName: "tab_other_selected"))
                .then {
                    $0.tag = TabBarItemType.other.rawValue
            }
        }
        
        let mainTabBarController = MainTabBarController().then {
            $0.viewControllers = [
                homeNav,
                cartNav,
//                favoriteNav,
//                sellNav,
                otherNav
            ]
        }

        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        let otherNavigator = OtherNavigator(navigationController: otherNav)
        otherNavigator.toOther()
        
        let homeNavigator = HomepageNavigator(navigationController: homeNav)
        homeNavigator.toHomePage()
        
        let cartNavigation = CartNavigator(navigationController: cartNav)
        cartNavigation.toCart()
    }
}
