//
//  UILabel.swift
//
//  Created by Dang Nguyen Vu on 7/20/17.
//  Copyright © 2017 s0hno. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setup(text: String?, font: UIFont, textColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.text = text
    }

    func setup(_ font: UIFont, textColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }

    func setup(_ font: UIFont, textColor: UIColor, aligment: NSTextAlignment, backgroundColor: UIColor = UIColor.clear) {
        self.setup(font, textColor: textColor, backgroundColor: backgroundColor)
        self.textAlignment = aligment
    }

    func setLineSpacing(lineHeight: CGFloat = 0.0,
                        alignment: NSTextAlignment = .left,
                        lineSpace: CGFloat = 0.0,
                        lineBreakMode: NSLineBreakMode = .byWordWrapping) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()

        let lineHeightMultiple = lineHeight / self.font.lineHeight

        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode

        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:
            paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
