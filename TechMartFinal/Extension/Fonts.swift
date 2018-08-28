//
//  Fonts.swift
//  Knot
//
//  Created by Tran Vuong Minh on 1/30/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

extension UIFont {
    enum HiraginoSansStyle {
        case w3
        case w6
        var name: String {
            switch self {
            case .w3:
                return "HiraginoSans-W3"
            case .w6:
                return "HiraginoSans-W6"
            }
        }
    }

    static func hiraginoSans(style: HiraginoSansStyle = .w3, size: CGFloat) -> UIFont {
        guard
            let font = UIFont(name: style.name, size: size),
            Int.bitWidth != 32 else {
            return UIFont.systemFont(ofSize: size)
        }
        return font.then {
            $0.ensureCorrectAlignment()
        }
    }
}
