//
//  FontConstant.swift
//  FAC_IOS
//
//  Created by dang.nguyen.vu on 5/2/18.
//  Copyright © 2018 DaoLQ. All rights reserved.
//

import Foundation
import UIKit

struct FontConstants {

    // TODO: Add More
    enum FontType {
        case regular
        case bold
    }

    static func font(_ type: FontType, _ fontSize: CGFloat) -> UIFont {
        switch type {
        case .regular:
            return UIFont.systemFont(ofSize: fontSize)
        case .bold:
            return UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
}
