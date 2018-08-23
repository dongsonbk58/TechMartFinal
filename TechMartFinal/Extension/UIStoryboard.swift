//
//  UIStoryBoard.swift
//
//  Created by Shohei Ohno on 2017/07/17.
//  Copyright © 2017年 s0hno. All rights reserved.
//

import UIKit

enum StoryboardType: String {
    case main
    case sideBarMenu
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        case .sideBarMenu:
            return "Sidebarmenu"
        }
    }
}

extension UIStoryboard {
    // swiftlint:disable force_cast
    class func instantiate<T: UIViewController>(_: T.Type, storyboardType: StoryboardType) -> T where T: Any {
        let storyboard = UIStoryboard(name: storyboardType.name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: T.className) as! T
    }
}
