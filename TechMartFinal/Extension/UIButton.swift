//
//  UIButton.swift
//
//  Created by Dang Nguyen Vu on 12/12/17.
//  Copyright © 2017 XProduction. All rights reserved.
//

import UIKit

//swiftlint:disable function_parameter_count
extension UIButton {

    func setup(title: String, font: UIFont, titleColor: UIColor, background: UIColor = UIColor.clear, controlState: UIControlState = .normal) {
        let attrTitle = NSAttributedString(string: title,
            attributes: [NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: titleColor])
        setBackgroundImage(UIImage.fromColor(background, size: bounds.size), for: controlState)
        setAttributedTitle(attrTitle, for: controlState)
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, imageBackground: UIImage, controlState: UIControlState = .normal) {
        setup(title: title, font: font, titleColor: titleColor, controlState: controlState)
        setBackgroundImage(imageBackground, for: controlState)
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor, controlState: UIControlState = .normal) {
        titleLabel?.font = font
        setTitleColor(titleColor, for: controlState)
        setTitle(title, for: controlState)
        self.backgroundColor = backgroundColor
    }

    func setup(title: String, font: UIFont, titleColor: UIColor, imageBackgroundFromColor: UIColor, controlState: UIControlState = .normal) {
        setup(title: title, font: font, titleColor: titleColor, controlState: controlState)
        setBackgroundImage(UIImage.fromColor(imageBackgroundFromColor, size: bounds.size), for: controlState)
    }

    func setup(image: UIImage, title: String, font: UIFont, tintColor: UIColor, imageBackgroundFromColor: UIColor, controlState: UIControlState) {
        setImage(image.withRenderingMode(.alwaysOriginal), for: controlState)
        self.tintColor = tintColor
        setup(title: title, font: font, titleColor:
                tintColor, imageBackgroundFromColor: imageBackgroundFromColor, controlState: controlState)
    }

    func swapImage() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }

    func centerVertically(withPadding padding: CGFloat = 6.0) {
        guard let imageSize = imageView?.frame.size, let titleSize = titleLabel?.frame.size else {
            return
        }
        let totalHeight = imageSize.height + titleSize.height + padding
        imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height),
            left: 0.0, bottom: 0.0, right: -titleSize.width)
        titleEdgeInsets = UIEdgeInsets(top: 0.0,
            left: -imageSize.width, bottom: -(totalHeight - titleSize.height), right: 0.0)
    }

    func border(width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = currentTitleColor.cgColor
    }
}
